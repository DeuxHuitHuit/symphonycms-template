<?php
	
	if(!defined('__IN_SYMPHONY__')) die('<h2>Error</h2><p>You cannot directly access this file</p>');
	
	require_once(TOOLKIT . '/class.event.php');
	
	class InsertSectionException extends Exception {
		
	}
	
	abstract class eventInsertSection extends Event {
		
		abstract protected function getActionName();
		abstract protected function getSection();
		abstract protected function getFieldValue($field);
		
		protected function getRequestMethod() {
			return 'POST';
		}
		
		protected function getRequestArray() {
			return $_POST;
		}

		public function load() {
			return $this->__trigger();
		}
		
		protected function __trigger() {
			
			$result = null;
			$actionName = $this->getActionName();
			$requestMethod = $this->getRequestMethod();
			$requestArray = $this->getRequestArray();
			
			if($_SERVER['REQUEST_METHOD'] == $requestMethod && isset($requestArray[$actionName]) ){
				
				$result = new XMLElement($actionName);
				
				$r = new XMLElement('result');
				
				try {
					
					$this->validate();
					$this->createEntryFromPost();
					$r->setAttribute('success', 'yes');
					
				} catch (Exception $ex) {
					
					$xmlEx = new XMLElement('error');
					
					$showMsg = $ex instanceof InsertSectionException || Symphony::Engine()->isLoggedIn();
					$errorMessage = $showMsg ? $ex->getMessage() : __('A Fatal error occured');
					
					$xmlEx->setValue($errorMessage); 
					
					$result->appendChild($xmlEx);
					
					$r->setAttribute('success', 'no');
				}
				
				$result->appendChild($r);
			} else {
				throw new FrontendPageNotFoundException();
			}
			
			return $result;
			
		}
		
		protected function validate() {}
		
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
				if ($data != null) {
					$entry->setData($f->get('id'), $data);
				}
			}
			
			if(!$entry->commit()) {
				throw new Exception('Could not create entry');
			}
		} 
	}