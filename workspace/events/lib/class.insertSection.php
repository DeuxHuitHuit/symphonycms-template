<?php
	
	if(!defined('__IN_SYMPHONY__')) die('<h2>Error</h2><p>You cannot directly access this file</p>');
	
	require_once(TOOLKIT . '/class.event.php');
	
	class InsertSectionException extends Exception {
		
	}
	
	abstract class eventInsertSection extends Event {
		
		abstract protected function getActionName();
		abstract protected function getSection();
		abstract protected function getFieldValue($field);
		
		protected function visitEntry(&$entry) {}
		
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
				
				$id = intval($_POST['id']);
				
				try {
					
					$this->validate();
					$entry = $this->createEntryFromPost($id);
					$this->visitEntry($entry);
					$r->setAttribute('success', 'yes');
					$r->setAttribute('id', $entry->get('id'));
					
				} catch (Exception $ex) {
					
					$xmlEx = new XMLElement('error');
					
					$showMsg = $ex instanceof InsertSectionException || Symphony::Engine()->isLoggedIn();
					$errorMessage = $showMsg ? $ex->getMessage() : __('A Fatal error occured');
					
					$xmlEx->setValue($errorMessage); 
					
					$result->appendChild($xmlEx);
					
					$r->setAttribute('success', 'no');
					
					Symphony::Log()->pushExceptionToLog($ex, true);
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
			
			$entry = null;
			if ($id > 0) {
				// edit
				$entry = EntryManager::fetch($id);
				if (empty($entry)) {
					throw new Exception(sprintf(__('Entry id %s not found'), $id));
				}
				$entry = $entry[0];
			} else {
				// create
				$entry = EntryManager::create();
				$entry->set('section_id', $source);
			}
			
			foreach ($fields as $f) {
				$data = $this->getFieldValue($f->get('element_name'));
				if ($data != null) {
					$entry->setData($f->get('id'), $data);
				}
			}
			
			if(!$entry->commit()) {
				throw new Exception(sprintf('Could not create entry: %s', mysql_error()));
			}
			
			return $entry;
		}
		
		// Per file setting
		const MAX_SIZE = 5242880; // 5 Mo = 1024 o * 1024 k * 5
		const DIR = '/uploads/';
		
		private static $EXT = array();
		
		protected function processFileUpload($key) {
			$value = array();
			$file = $_FILES[$key];
			
			if (empty($file) || empty($file['name']) || empty($file['tmp_name'])) {
				return $value;
			}
			
			$size = intval($file['size']);
			$ext = strtolower(pathinfo($file['name'], PATHINFO_EXTENSION));
			$filename = $file['name'];
			
			if ($size > self::MAX_SIZE) {
				throw new Exception(sprintf("File is too big: %d when the max is %d", $size, self::MAX_SIZE));
			}
			
			if (!$ext || !in_array($ext, self::$EXT) ) {
				throw new Exception(sprintf("File '%s' is not allowed. Please upload '%s' files only", $filename, implode(', ', self::$EXT)));
			}
			
			// unique file name
			$filename = time() . '-' . Lang::createFilename($file['name']);
			
			$value['file'] = self::DIR . $filename;
			$value['size'] = $size;
			
			// make a copy - to have the good name and ext
			$ret = General::uploadFile(
				WORKSPACE . self::DIR, $filename, $file['tmp_name'],
				Symphony::Configuration()->get('write_mode', 'file')
			);
			
			if ($ret) {
				return $value;
			} else {
				throw new Exception(sprintf('Could not save file `%s`. ', $filename));
			}
			return null;
		}
	}