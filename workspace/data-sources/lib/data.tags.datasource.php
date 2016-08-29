<?php

require_once(TOOLKIT . '/class.datasource.php');
require_once(EXTENSIONS . '/frontend_localisation/lib/class.FLang.php');

abstract class TagsDatasource extends Datasource {

	public function __construct($env=NULL, $process_params=true) {
		parent::__construct($env, $process_params);
		$this->_dependencies = array();
	}

	public function allowEditorToParse() {
		return false;
	}

	public function execute(array &$param_pool = null) {
		$result = new XMLElement($this->dsParamROOTELEMENT);
		
		
		try {
			if (!isset($this->dsParamTAGFIELD)) {
				throw new Exception('dsParamTAGFIELD is undefined');
			}
			$lang = "fr";
			if (isset($_REQUEST['fl-language'])) {
				$lang = MySQL::cleanValue($_REQUEST['fl-language']);
			}
			$resultData = Symphony::Database()->fetchCol('value-' . $lang, sprintf(
				"SELECT DISTINCT `value-". $lang ."`
					FROM sym_entries_data_%d 
					WHERE `value-". $lang ."` IS NOT NULL
					ORDER BY `value-". $lang ."` ASC",
				$this->dsParamTAGFIELD
			));
			
			foreach ($resultData as $value) {
				$e = new XMLElement('entry', htmlspecialchars($value));
				$e->setAttribute('handle', Lang::createHandle(strip_tags(html_entity_decode($value))));
				
				$result->appendChild($e);
			}
		}
		catch (FrontendPageNotFoundException $e){
			// Work around. This ensures the 404 page is displayed and
			// is not picked up by the default catch() statement below
			FrontendPageNotFoundExceptionHandler::render($e);
		}
		catch (Exception $e){
			$result->appendChild(new XMLElement('error', $e->getMessage() . ' on ' . $e->getLine() . ' of file ' . $e->getFile()));
			return $result;
		}

		if ($this->_force_empty_result) {
			$result = $this->emptyXMLSet();
		}

		return $result;
	}

}
