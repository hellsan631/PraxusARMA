<?php

/**
 * Services are globally registered in this file
 */


use Phalcon\Mvc\Url as UrlResolver;
use Phalcon\DI\FactoryDefault;
use Phalcon\Db\Adapter\Pdo\Mysql as DbAdapter;
use Phalcon\Session\Adapter\Files as SessionAdapter;

/**
 * The FactoryDefault Dependency Injector automatically registers the right services to provide a full stack framework
 */
$di = new FactoryDefault();

/**
 * Read configuration
 */
$config = include __DIR__ . "/config.php";

/**
 * Database connection is created based in the parameters defined in the configuration file
 */
$di['db'] = function () use ($config) {
    return new DbAdapter(array(
        "host" => $config->database->host,
        "username" => $config->database->username,
        "password" => $config->database->password,
        "dbname" => $config->database->name,
        "charset" => $config->database->charset
    ));
};

/**
 * Registering a router
 */
$di->set(
    'router',
    function () {
        return include __DIR__ . "/routes.php";
    },
    true
);

/**
 * The URL component is used to generate all kinds of URLs in the application
 */
$di['url'] = function () {
    $url = new UrlResolver();
    $url->setBaseUri('/PraxusARMA/');

    return $url;
};

/**
 * Starts the session the first time some component requests the session service
 */
$di['session'] = function () {
    $session = new SessionAdapter();
    $session->start();

    return $session;
};
