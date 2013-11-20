<?php

	if(!defined('__IN_SYMPHONY__')) die('<h2>Error</h2><p>You cannot directly access this file</p>');

	require_once(TOOLKIT . '/class.event.php');

	abstract class eventInsertSection extends Event {

		abstract protected function getActionName();
		abstract protected function getSection();
		abstract protected function getFieldValue($field);
		
		protected function getRequestMethod() {
			return 'POST';
		}

		public function load() {
			return $this->__trigger();
		}

		protected function __trigger() {

			$result = null;
			$actionName = $this->getActionName();
			$requestMethod = $this->getRequestMethod();
			
			if($_SERVER['REQUEST_METHOD'] == $requestMethod && isset($_POST[$actionName]) ){

				$result = new XMLElement($actionName);
				
				$r = new XMLElement('result');
				
				try {

					$this->createEntryFromPost();

					$r->setAttribute('success', 'yes');

				} catch (Exception $ex) {

					$xmlEx = new XMLElement('error');

					$errorMessage = Symphony::Engine()->isLoggedIn() ? $ex->getMessage() : 'A Fatal error occured';
					
					$xmlEx->setValue($errorMessage); 

					$result->appendChild($xmlEx);

					$r->setAttribute('success', 'no');
				}

				$result->appendChild($r);
			}

			return $result;

		}

		private function createEntryFromPost() {
			include_once(TOOLKIT . '/class.sectionmanager.php');
			include_once(TOOLKIT . '/class.entrymanager.php');

			// section id
			$source = $this->getSection();

			$section = SectionManager::fetch($source);

			$fields = $section->fetchFields();

			$entry = EntryManager::create();
			$entry->set('section_id', $source);

			foreach ($fields as $f) {
				$data = $this->getFieldValue($f->get('element_name'));
				$entry->setData($f->get('id'), $data);
			}

			if(!$entry->commit()) {
				throw new Exception('Could not create entry');
			}
		} 
	}