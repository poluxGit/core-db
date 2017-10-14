-- -------------------------------------------------------------------------- --
-- TARGET_SCHEMA - Database - Deployment Script - Tables and indexes          --
-- -------------------------------------------------------------------------- --
-- @author : poluxGit <polux@poluxfr.org>                                     --
-- -------------------------------------------------------------------------- --
-- Database version : TARGET_VERSION                                              --
-- Generation time : GEN_DATE                                                 --
-- -------------------------------------------------------------------------- --
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -------------------------------------------------------------------------- --
-- CORE Application Main Database `TARGET_SCHEMA`                            --
-- -------------------------------------------------------------------------- --
DROP SCHEMA IF EXISTS `TARGET_SCHEMA`;
CREATE SCHEMA IF NOT EXISTS `TARGET_SCHEMA` DEFAULT CHARACTER SET utf8 ;
USE `TARGET_SCHEMA`;
