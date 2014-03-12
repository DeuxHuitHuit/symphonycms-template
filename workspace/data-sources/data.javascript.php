<?php

	require_once(TOOLKIT . '/class.datasource.php');

	Class datasourcejavascript extends Datasource {

		public $dsParamROOTELEMENT = 'javascript';

		public function __construct($env=NULL, $process_params=true) {
			parent::__construct($env, $process_params);
			$this->_dependencies = array();
		}

		public function about() {
			return array(
				'name' => 'Javascript',
				'author' => array(
					'name' => 'Deux Huit Huit',
					'website' => 'http://deuxhutihuit.com',
					'email' => 'open-source@deuxhuithuit.com'),
				'version' => 'Symphony 2.3.6',
				'release-date' => '2014-03-12T19:25:30+00:00'
			);
		}

		public function getSource() {
			return 'js.json';
		}

		public function allowEditorToParse() {
			return false;
		}
		
		protected function getJSONFilePath() {
			return WORKSPACE . '/assets/js.json';
		}
		
		public function execute(array &$param_pool = null) {
			$result = new XMLElement($this->dsParamROOTELEMENT);
			
			try {
				$filePath = $this->getJSONFilePath();
				
				if (file_exists($filePath)) {
					$fileString = file_get_contents($filePath);
					
					$json = @json_decode($fileString, true);
					
					if (is_array($json)) {
						foreach ($json as $index => $file) {
							$result->appendChild(new XMLElement('file', $file));
						}
					}
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
