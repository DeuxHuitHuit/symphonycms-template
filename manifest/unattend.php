<?php
    $settings = array(


        ###### ADMIN ######
        'admin' => array(
            'max_upload_size' => '5242880',
            'upload_blacklist' => '/\.(?:php[34567s]?|phtml)$/i',
        ),
        ########


        ###### SYMPHONY ######
        'symphony' => array(
            'admin-path' => 'symphony',
            'pagination_maximum_rows' => '20',
            'association_maximum_rows' => '5',
            'lang' => 'en',
            'pages_table_nest_children' => 'no',
            'version' => VERSION,
            'cookie_prefix' => 'sym-',
            'session_gc_divisor' => '10',
            'session_strict_domain' => 'yes',
            'cell_truncation_length' => '75',
            'enable_xsrf' => 'yes',
            'error_reporting_all' => 'no',
        ),
        ########


        ###### LOG ######
        'log' => array(
            'archive' => '1',
            'maxsize' => '5242880',
            'filter' => E_ALL ^ E_DEPRECATED,
        ),
        ########


        ###### DATABASE ######
        'database' => array(
            'host' => 'localhost',
            'port' => '3306',
            'user' => null,
            'password' => null,
            'db' => null,
            'driver' => 'mysql',
            'charset' => 'utf8mb4',
            'collate' => 'utf8mb4_unicode_ci',
            'engine' => 'InnoDB',
            'tbl_prefix' => 'sym_',
            'query_caching' => 'on',
            'query_logging' => 'on'
        ),
        ########


        ###### PUBLIC ######
        'public' => array(
            'display_event_xml_in_source' => 'no',
        ),
        ########


        ###### GENERAL ######
        'general' => array(
            'sitename' => 'Symphony CMS',
            'useragent' => 'Symphony/' . VERSION,
        ),
        ########


        ###### FILE ######
        'file' => array(
            'write_mode' => '0644',
        ),
        ########


        ###### DIRECTORY ######
        'directory' => array(
            'write_mode' => '0755',
        ),
        ########


        ###### REGION ######
        'region' => array(
            'time_format' => 'g:i a',
            'date_format' => 'm/d/Y',
            'datetime_separator' => ' ',
            'timezone' => null
        ),
        ########


        ###### CACHE ######
        'cache_driver' => array(
            'default' => 'database',
        ),
        ########


        ###### FORM-DYN ######
        'form-dyn' => array(
            'allowed-extensions' => 'png,jpg,jpeg,pdf,doc,docx',
            'max-upload-size' => 5242880,
            'responses' => '34',
            'form' => '206',
            'results' => '207',
            'form-name' => '160',
            'form-title' => '160',
            'form-fields' => '165',
            'form-field-name-handle' => 'name',
            'form-recipients' => '161',
            'destination-field' => '1156',
            'form-email-subject' => '162',
            'form-email-body' => '163',
            'form-extra-fields' => null,
            'form-extra-fields-handle' => null,
            'form-extra-fields-value' => null,
            'responses-extra-fields' => null,
            'pingback-url' => '164',
            'upload-dir' => '/workspace/user-uploads',
        ),
        ########
    );
