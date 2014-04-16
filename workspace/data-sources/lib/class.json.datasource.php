<?php

	require_once(TOOLKIT . '/class.datasource.php');

	abstract Class JSONDataSource extends Datasource {

		public function __construct($env=NULL, $process_params=true) {
			parent::__construct($env, $process_params);
			$this->_dependencies = array();
		}

		public function allowEditorToParse() {
			return false;
		}
		
		protected abstract function getJSONFilePath();
		
		protected abstract function decode(XMLElement &$result, array $json);
		
		public function execute(array &$param_pool = null) {
			$result = new XMLElement($this->dsParamROOTELEMENT);
			
			try {
				$filePath = $this->getJSONFilePath();
				
				if (file_exists($filePath)) {
					$fileString = file_get_contents($filePath);
					
					$json = @json_decode($fileString, true);
					
					if (is_array($json)) {
						$this->decode($result, $json);
					} else {
						throw new Exception(__('Could not read json from %s', array($filePath)));
					}
				} else {
					throw new Exception(__('File %s not found', array($filePath)));
				}
			}
			catch(FrontendPageNotFoundException $e){
				// Work around. This ensures the 404 page is displayed and
				// is not picked up by the default catch() statement below
				FrontendPageNotFoundExceptionHandler::render($e);
			}
			catch(Exception $e){
				$result->appendChild(new XMLElement('error', $e->getMessage() . ' on ' . $e->getLine() . ' of file ' . $e->getFile()));
				return $result;
			}

			return $result;
		}

	}
