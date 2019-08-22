<?php

class datasourceform_config extends SectionDatasource
{
    public $dsParamROOTELEMENT = 'form-config';
    public $dsParamORDER = 'desc';
    public $dsParamPAGINATERESULTS = 'no';
    public $dsParamLIMIT = '20';
    public $dsParamSTARTPAGE = '1';
    public $dsParamREDIRECTONEMPTY = 'no';
    public $dsParamREDIRECTONFORBIDDEN = 'no';
    public $dsParamREDIRECTONREQUIRED = 'no';
    public $dsParamPARAMXML = 'no';
    public $dsParamSORT = 'system:id';
    public $dsParamHTMLENCODE = 'no';
    public $dsParamASSOCIATEDENTRYCOUNTS = 'no';

    public $dsParamINCLUDEDELEMENTS = array(
        'hint-required: formatted',
        'hint-invalid: formatted',
        'hint-image-invalid: formatted',
        'hint-email-invalid: formatted',
        'hint-document-invalid: formatted',
        'hint-phoneus-invalid: formatted',
        'hint-date-invalid: formatted',
        'hint-url-invalid: formatted',
        'message-success: formatted',
        'message-error: formatted',
        'upload: formatted',
        'submit: formatted'
    );

    public function __construct($env = null, $process_params = true)
    {
        parent::__construct($env, $process_params);
        $this->_dependencies = array();
    }

    public function about()
    {
        return array(
            'name' => 'Form Config',
            'author' => array(
                'name' => 'Dominic Blain',
                'website' => 'https://starterkit.288dev.com',
                'email' => 'dominic@deuxhuithuit.com'),
            'version' => 'Symphony 4.0.0',
            'release-date' => '2019-07-24T14:19:56+00:00'
        );
    }

    public function getSource()
    {
        return '19';
    }

    public function allowEditorToParse()
    {
        return true;
    }
}