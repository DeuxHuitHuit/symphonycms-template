<?php

require_once(EXTENSIONS.'/page_lhandles/lib/class.datasource.MultilingualNavigation.php');

class datasourcenavigation extends MultilingualNavigationDatasource
{
    public $dsParamROOTELEMENT = 'navigation';
    public $dsParamORDER = 'desc';
    public $dsParamREDIRECTONEMPTY = 'no';
    public $dsParamREDIRECTONFORBIDDEN = 'no';
    public $dsParamREDIRECTONREQUIRED = 'no';
    public $dsParamSORT = 'id';

    public function __construct($env = null, $process_params = true)
    {
        parent::__construct($env, $process_params);
        $this->_dependencies = array();
    }

    public function about()
    {
        return array(
            'name' => 'Navigation',
            'author' => array(
                'name' => 'Vincent Rouleau',
                'website' => 'https://starterkit.288dev.com',
                'email' => 'vincent@deuxhuithuit.com'),
            'version' => 'Symphony 4.0.0',
            'release-date' => '2019-07-15T14:57:42+00:00'
        );
    }

    public function getSource()
    {
        return 'navigation';
    }

    public function allowEditorToParse()
    {
        return true;
    }
}