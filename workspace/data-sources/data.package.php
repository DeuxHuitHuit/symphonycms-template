<?php

	require_once(DATASOURCES . '/lib/class.json.datasource.php');

	Class datasourcepackage extends JSONDataSource {

		public $dsParamROOTELEMENT = 'package';

		public function __construct($env=NULL, $process_params=true) {
			parent::__construct($env, $process_params);
			$this->_dependencies = array();
		}

		public function about() {
			return array(
				'name' => 'Package.json',
				'author' => array(
					'name' => 'Deux Huit Huit',
					'website' => 'http://deuxhutihuit.com',
					'email' => 'open-source@deuxhuithuit.com'),
				'version' => 'Symphony 2.4.x',
				'release-date' => '2014-03-12T19:25:30+00:00'
			);
		}

		public function getSource() {
			return 'package.json';
		}

		protected function getJSONFilePath() {
			return WORKSPACE . '/assets/package.json';
		}
		
		protected function decode(XMLElement &$result, array $json) {
			$result = new XMLElement($this->dsParamROOTELEMENT);
			
			$result->appendChild(new XMLElement('name', $json['name']));
			$result->appendChild(new XMLElement('version', $json['version']));
			
			return $result;
		}

	}
