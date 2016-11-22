<?php

	require_once(TOOLKIT . '/class.datasource.php');

	Class datasourcepage_metas extends SectionDatasource {

		public $dsParamROOTELEMENT = 'page-metas';
		public $dsParamORDER = 'desc';
		public $dsParamPAGINATERESULTS = 'yes';
		public $dsParamLIMIT = '1';
		public $dsParamSTARTPAGE = '1';
		public $dsParamREDIRECTONEMPTY = 'no';
		public $dsParamSORT = 'system:id';
		public $dsParamASSOCIATEDENTRYCOUNTS = 'no';

		public $dsParamFILTERS = array(
			'18' => '{$current-page-id}',
		);

		public $dsParamINCLUDEDELEMENTS = array(
			'description: formatted',
			'titre: formatted',
			'image-partage'
		);

		public function __construct($env=NULL, $process_params=true) {
			parent::__construct($env, $process_params);
			$this->_dependencies = array();
		}

		public function about() {
			return array(
				'name' => 'Site: Page Metas',
				'author' => array(
					'name' => 'Deux Huit Huit',
					'website' => 'https://deuxhuithuit.com',
					'email' => 'open-source@deuxhuithuit.com'
				),
				'version' => 'Symphony 2.6.x',
				'release-date' => '2011-11-22T18:21:43+00:00'
			);
		}

		public function getSource() {
			return '4';
		}

		public function allowEditorToParse() {
			return false;
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

			if($this->_negate_result) $result = $this->negateXMLSet();

			return $result;
		}

	}