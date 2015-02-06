<?php

/**
 * Register application modules
 */
$application->registerModules(array(
    'frontend' => array(
        'className' => 'PraxusARMA\Frontend\Module',
        'path' => __DIR__ . '/../apps/frontend/Module.php'
    ),
    'backend' => array(
        'className' => 'PraxusARMA\Backend\Module',
        'path' => __DIR__ . '/../apps/backend/Module.php'
    )
));
