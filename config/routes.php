<?php

use Phalcon\Mvc\Router;

$router = new Router();

$router->setDefaultModule('frontend');

$router->setDefaultNamespace('PraxusARMA\Frontend\Controllers');

$router->add("/admin", array(
    'namespace'  => 'PraxusARMA\Backend\Controllers',
    'module'     => 'backend',
    'controller' => 'index',
    'action'     => 'index',
));

$router->add("/admin/", array(
    'namespace'  => 'PraxusARMA\Backend\Controllers',
    'module'     => 'backend',
    'controller' => 'index',
    'action'     => 'index',
));

$router->add("/admin/:controller", array(
    'namespace'  => 'PraxusARMA\Backend\Controllers',
    'module'     => 'backend',
    'controller' => 1,
    'action'     => 'index',
));

$router->add("/admin/:controller/", array(
    'namespace'  => 'PraxusARMA\Backend\Controllers',
    'module'     => 'backend',
    'controller' => 1,
    'action'     => 'index',
));

$router->add("/admin/:controller/:action", array(
    'namespace'  => 'PraxusARMA\Backend\Controllers',
    'module'     => 'backend',
    'controller' => 1,
    'action'     => 2
));

$router->add("/admin/:controller/:action/", array(
    'namespace'  => 'PraxusARMA\Backend\Controllers',
    'module'     => 'backend',
    'controller' => 1,
    'action'     => 2
));

$router->add("/admin/:controller/:action/:params", array(
    'namespace'  => 'PraxusARMA\Backend\Controllers',
    'module'     => 'backend',
    "controller" => 1,
    "action"     => 2,
    "params"     => 3
));

return $router;