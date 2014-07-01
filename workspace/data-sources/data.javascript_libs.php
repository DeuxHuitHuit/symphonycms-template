<?php

	require_once(DATASOURCES . '/lib/class.json.datasource.php');

	Class datasourcejavascript_libs extends JSONDataSource {

		public $dsParamROOTELEMENT = 'javascript-libs';

		public function __construct($env=NULL, $process_params=true) {
			parent::__construct($env, $process_params);
			$this->_dependencies = array();
		}

		public function about() {
			return array(
				'name' => 'Javascript Libs',
				'author' => array(
					'name' => 'Deux Huit Huit',
					'website' => 'http://deuxhutihuit.com',
					'email' => 'open-source@deuxhuithuit.com'),
				'version' => 'Symphony 2.4.x',
				'release-date' => '2014-04-16T17:08:30+00:00'
			);
		}

		public function getSource() {
			return 'js.json';
		}

		protected function getJSONFilePath() {
			return WORKSPACE . '/assets/js-libs.json';
		}
		
		protected function decode(XMLElement &$result, array $json) {
			$result = new XMLElement($this->dsParamROOTELEMENT);
			
			foreach ($json as $index => $file) {
				$result->appendChild(new XMLElement('file', $file));
			}
			
			return $result;
		}

	}
