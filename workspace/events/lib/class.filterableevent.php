<?php

if(!defined('__IN_SYMPHONY__')) die('<h2>Error</h2><p>You cannot directly access this file</p>');

// In Symphony 3.0.0, the class now exists
if (class_exists('FilterableEvent', true)) {
    return;
}

abstract class FilterableEvent extends Event {
    protected $filter_results = array();
    
    /**
     * Processes all extensions attached to the `EventPreSaveFilter` delegate
     *
     * @uses EventPreSaveFilter
     *
     * @param XMLElement $result
     * @param array $fields
     * @param XMLElement $post_values
     * @param integer $entry_id
     * @return boolean
     */
    protected function processPreSaveFilters(XMLElement $result, array &$fields, XMLElement &$post_values, $entry_id = null)
    {
        $can_proceed = true;

        /**
         * Prior to saving entry from the front-end. This delegate will
         * force the Event to terminate if it populates the `$filter_results`
         * array. All parameters are passed by reference.
         *
         * @delegate EventPreSaveFilter
         * @param string $context
         * '/frontend/'
         * @param array $fields
         * @param Event $this
         * @param array $messages
         *  An associative array of array's which contain 4 values,
         *  the name of the filter (string), the status (boolean),
         *  the message (string) an optionally an associative array
         *  of additional attributes to add to the filter element.
         * @param XMLElement $post_values
         * @param integer $entry_id
         *  If editing an entry, this parameter will be an integer,
         *  otherwise null.
         */
        Symphony::ExtensionManager()->notifyMembers(
            'EventPreSaveFilter',
            '/frontend/',
            array(
                'fields' => &$fields,
                'event' => &$this,
                'messages' => &$this->filter_results,
                'post_values' => &$post_values,
                'entry_id' => $entry_id
            )
        );

        // Logic taken from `event.section.php` to fail should any `$this->filter_results`
        // be returned. This delegate can cause the event to exit early.
        if (is_array($this->filter_results) && !empty($this->filter_results)) {
            $can_proceed = true;

            foreach ($this->filter_results as $fr) {
                list($name, $status, $message, $attributes) = array_pad($fr, 4, null);

                $result->appendChild(
                    SectionEvent::buildFilterElement($name, ($status ? 'passed' : 'failed'), $message, $attributes)
                );

                if ($status === false) {
                    $can_proceed = false;
                }
            }

            if ($can_proceed !== true) {
                $result->appendChild($post_values);
                $result->setAttribute('result', 'error');
                $result->appendChild(new XMLElement('message', __('Entry encountered errors when saving.'), array(
                    'message-id' => EventMessages::FILTER_FAILED
                )));
            }
        }

        // Reset the filter results to prevent duplicates. RE: #2179
        $this->filter_results = array();
        return $can_proceed;
    }
}