<?php

	require_once(TOOLKIT . '/class.datasource.php');

	Class datasourcemenu extends SectionDatasource {

		public $dsParamROOTELEMENT = 'menu';
		public $dsParamORDER = 'asc';
		public $dsParamPAGINATERESULTS = 'yes';
		public $dsParamLIMIT = '6';
		public $dsParamSTARTPAGE = '1';
		public $dsParamREDIRECTONEMPTY = 'no';
		public $dsParamSORT = 'ordre';
		public $dsParamASSOCIATEDENTRYCOUNTS = 'no';
		

		public $dsParamFILTERS = array(
				'15' => '{$login-filter}',
		);
		

		public $dsParamINCLUDEDELEMENTS = array(
				'page',
				'titre: formatted'
		);
		

		public function __construct($env=NULL, $process_params=true) {
			parent::__construct($env, $process_params);
			$this->_dependencies = array();
		}

		public function about() {
			return array(
				'name' => 'Menu',
				'author' => array(
					'name' => 'Deux Huit Huit',
					'website' => 'http://deuxhuithuit.com',
					'email' => 'open-source@deuxhuithuit.com'),
				'version' => 'Symphony 2.4.x',
				'release-date' => '2014-03-04T16:33:52+00:00'
			);
		}

		public function getSource() {
			return '2';
		}

		public function allowEditorToParse() {
			return true;
		}

		public function execute(array &$param_pool = null) {
			$result = new XMLElement($this->dsParamROOTELEMENT);

			try{
				$result = parent::execute($param_pool);
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

			if($this->_force_empty_result) $result = $this->emptyXMLSet();

			return $result;
		}

	}
