/*
 Navicat Premium Data Transfer

 Source Server         : L_Homestead_本机数据库
 Source Server Type    : MySQL
 Source Server Version : 80036 (8.0.36-0ubuntu0.22.04.1)
 Source Host           : localhost:33060
 Source Schema         : base11nova

 Target Server Type    : MySQL
 Target Server Version : 80036 (8.0.36-0ubuntu0.22.04.1)
 File Encoding         : 65001

 Date: 26/04/2024 13:24:06
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for action_events
-- ----------------------------
DROP TABLE IF EXISTS `action_events`;
CREATE TABLE `action_events` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `batch_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `actionable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `actionable_id` bigint unsigned NOT NULL,
  `target_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `target_id` bigint unsigned NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned DEFAULT NULL,
  `fields` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'running',
  `exception` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `original` mediumtext COLLATE utf8mb4_unicode_ci,
  `changes` mediumtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `action_events_actionable_type_actionable_id_index` (`actionable_type`,`actionable_id`),
  KEY `action_events_target_type_target_id_index` (`target_type`,`target_id`),
  KEY `action_events_batch_id_model_type_model_id_index` (`batch_id`,`model_type`,`model_id`),
  KEY `action_events_user_id_index` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of action_events
-- ----------------------------
BEGIN;
INSERT INTO `action_events` (`id`, `batch_id`, `user_id`, `name`, `actionable_type`, `actionable_id`, `target_type`, `target_id`, `model_type`, `model_id`, `fields`, `status`, `exception`, `created_at`, `updated_at`, `original`, `changes`) VALUES (1, '9bba3ae0-b1f4-4e17-ab47-1a6252b7d9e3', 1, 'Update', 'App\\Models\\AdminUser', 1, 'App\\Models\\AdminUser', 1, 'App\\Models\\AdminUser', 1, '', 'finished', '', '2024-04-04 22:39:00', '2024-04-04 22:39:00', '[]', '[]');
COMMIT;

-- ----------------------------
-- Table structure for activity_log
-- ----------------------------
DROP TABLE IF EXISTS `activity_log`;
CREATE TABLE `activity_log` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `log_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `event` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `causer_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `causer_id` bigint unsigned DEFAULT NULL,
  `properties` json DEFAULT NULL,
  `batch_uuid` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `subject` (`subject_type`,`subject_id`),
  KEY `causer` (`causer_type`,`causer_id`),
  KEY `activity_log_log_name_index` (`log_name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of activity_log
-- ----------------------------
BEGIN;
INSERT INTO `activity_log` (`id`, `log_name`, `description`, `subject_type`, `event`, `subject_id`, `causer_type`, `causer_id`, `properties`, `batch_uuid`, `created_at`, `updated_at`) VALUES (1, 'default', 'created', 'App\\Models\\Settings', 'created', '0', NULL, NULL, '{\"ip\": \"192.168.56.1\", \"attributes\": {\"key\": \"is_enable\", \"value\": \"1\"}}', NULL, '2024-04-04 22:37:02', '2024-04-04 22:37:02');
INSERT INTO `activity_log` (`id`, `log_name`, `description`, `subject_type`, `event`, `subject_id`, `causer_type`, `causer_id`, `properties`, `batch_uuid`, `created_at`, `updated_at`) VALUES (2, 'default', 'updated', 'App\\Models\\Settings', 'updated', '0', NULL, NULL, '{\"ip\": \"192.168.56.1\", \"old\": {\"value\": \"1\"}, \"attributes\": {\"value\": \"2\"}}', NULL, '2024-04-04 22:37:14', '2024-04-04 22:37:14');
INSERT INTO `activity_log` (`id`, `log_name`, `description`, `subject_type`, `event`, `subject_id`, `causer_type`, `causer_id`, `properties`, `batch_uuid`, `created_at`, `updated_at`) VALUES (3, 'default', 'updated', 'App\\Models\\AdminUser', 'updated', '1', 'App\\Models\\AdminUser', 1, '{\"ip\": \"192.168.56.1\", \"old\": {\"password\": \"$2y$12$JwSTVqsb9IjBkJx6iiX.Gu0pzNs.dWXUxHEBhxXlmCksAIyEugct.\", \"updated_at\": \"2024-04-04 21:12:05\"}, \"attributes\": {\"password\": \"$2y$12$5A0QVEokj03w.3wrOZGPSu/cKOE3HaxzpNFXv3/pSmIxWidn9CUYO\", \"updated_at\": \"2024-04-04 22:39:00\"}}', NULL, '2024-04-04 22:39:00', '2024-04-04 22:39:00');
INSERT INTO `activity_log` (`id`, `log_name`, `description`, `subject_type`, `event`, `subject_id`, `causer_type`, `causer_id`, `properties`, `batch_uuid`, `created_at`, `updated_at`) VALUES (4, 'default', 'updated', 'App\\Models\\Settings', 'updated', 'site_name', NULL, NULL, '{\"ip\": \"192.168.56.1\", \"old\": {\"value\": \"2\"}, \"attributes\": {\"value\": \"1\"}}', NULL, '2024-04-04 22:41:15', '2024-04-04 22:41:15');
COMMIT;

-- ----------------------------
-- Table structure for admin_users
-- ----------------------------
DROP TABLE IF EXISTS `admin_users`;
CREATE TABLE `admin_users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='管理员用户';

-- ----------------------------
-- Records of admin_users
-- ----------------------------
BEGIN;
INSERT INTO `admin_users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `deleted_at`) VALUES (1, 'Admin', 'admin@admin.com', NULL, '$2y$12$5A0QVEokj03w.3wrOZGPSu/cKOE3HaxzpNFXv3/pSmIxWidn9CUYO', NULL, '2024-04-04 21:12:05', '2024-04-04 22:39:00', NULL);
COMMIT;

-- ----------------------------
-- Table structure for cache
-- ----------------------------
DROP TABLE IF EXISTS `cache`;
CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of cache
-- ----------------------------
BEGIN;
INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES ('nova_valid_license_key', 'b:0;', 1714105808);
INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES ('spatie.permission.cache', 'a:3:{s:5:\"alias\";a:6:{s:1:\"a\";s:2:\"id\";s:1:\"b\";s:4:\"name\";s:1:\"c\";s:5:\"group\";s:1:\"d\";s:10:\"guard_name\";s:1:\"g\";s:5:\"title\";s:1:\"r\";s:5:\"roles\";}s:11:\"permissions\";a:42:{i:0;a:6:{s:1:\"a\";i:1;s:1:\"b\";s:15:\"viewAnyActivity\";s:1:\"c\";s:8:\"Activity\";s:1:\"d\";s:6:\"admins\";s:1:\"g\";s:18:\"操作日志列表\";s:1:\"r\";a:1:{i:0;i:1;}}i:1;a:6:{s:1:\"a\";i:2;s:1:\"b\";s:12:\"viewActivity\";s:1:\"c\";s:8:\"Activity\";s:1:\"d\";s:6:\"admins\";s:1:\"g\";s:18:\"查看操作日志\";s:1:\"r\";a:1:{i:0;i:1;}}i:2;a:6:{s:1:\"a\";i:3;s:1:\"b\";s:14:\"createActivity\";s:1:\"c\";s:8:\"Activity\";s:1:\"d\";s:6:\"admins\";s:1:\"g\";s:18:\"创建操作日志\";s:1:\"r\";a:1:{i:0;i:1;}}i:3;a:6:{s:1:\"a\";i:4;s:1:\"b\";s:14:\"updateActivity\";s:1:\"c\";s:8:\"Activity\";s:1:\"d\";s:6:\"admins\";s:1:\"g\";s:18:\"更新操作日志\";s:1:\"r\";a:1:{i:0;i:1;}}i:4;a:6:{s:1:\"a\";i:5;s:1:\"b\";s:14:\"deleteActivity\";s:1:\"c\";s:8:\"Activity\";s:1:\"d\";s:6:\"admins\";s:1:\"g\";s:18:\"删除操作日志\";s:1:\"r\";a:1:{i:0;i:1;}}i:5;a:6:{s:1:\"a\";i:6;s:1:\"b\";s:15:\"restoreActivity\";s:1:\"c\";s:8:\"Activity\";s:1:\"d\";s:6:\"admins\";s:1:\"g\";s:18:\"恢复操作日志\";s:1:\"r\";a:1:{i:0;i:1;}}i:6;a:6:{s:1:\"a\";i:7;s:1:\"b\";s:19:\"forceDeleteActivity\";s:1:\"c\";s:8:\"Activity\";s:1:\"d\";s:6:\"admins\";s:1:\"g\";s:24:\"强制删除操作日志\";s:1:\"r\";a:1:{i:0;i:1;}}i:7;a:6:{s:1:\"a\";i:8;s:1:\"b\";s:16:\"viewAnyAdminUser\";s:1:\"c\";s:9:\"AdminUser\";s:1:\"d\";s:6:\"admins\";s:1:\"g\";s:15:\"管理员列表\";s:1:\"r\";a:1:{i:0;i:1;}}i:8;a:6:{s:1:\"a\";i:9;s:1:\"b\";s:13:\"viewAdminUser\";s:1:\"c\";s:9:\"AdminUser\";s:1:\"d\";s:6:\"admins\";s:1:\"g\";s:15:\"查看管理员\";s:1:\"r\";a:1:{i:0;i:1;}}i:9;a:6:{s:1:\"a\";i:10;s:1:\"b\";s:15:\"createAdminUser\";s:1:\"c\";s:9:\"AdminUser\";s:1:\"d\";s:6:\"admins\";s:1:\"g\";s:15:\"创建管理员\";s:1:\"r\";a:1:{i:0;i:1;}}i:10;a:6:{s:1:\"a\";i:11;s:1:\"b\";s:15:\"updateAdminUser\";s:1:\"c\";s:9:\"AdminUser\";s:1:\"d\";s:6:\"admins\";s:1:\"g\";s:15:\"更新管理员\";s:1:\"r\";a:1:{i:0;i:1;}}i:11;a:6:{s:1:\"a\";i:12;s:1:\"b\";s:15:\"deleteAdminUser\";s:1:\"c\";s:9:\"AdminUser\";s:1:\"d\";s:6:\"admins\";s:1:\"g\";s:15:\"删除管理员\";s:1:\"r\";a:1:{i:0;i:1;}}i:12;a:6:{s:1:\"a\";i:13;s:1:\"b\";s:16:\"restoreAdminUser\";s:1:\"c\";s:9:\"AdminUser\";s:1:\"d\";s:6:\"admins\";s:1:\"g\";s:15:\"恢复管理员\";s:1:\"r\";a:1:{i:0;i:1;}}i:13;a:6:{s:1:\"a\";i:14;s:1:\"b\";s:20:\"forceDeleteAdminUser\";s:1:\"c\";s:9:\"AdminUser\";s:1:\"d\";s:6:\"admins\";s:1:\"g\";s:21:\"强制删除管理员\";s:1:\"r\";a:1:{i:0;i:1;}}i:14;a:6:{s:1:\"a\";i:15;s:1:\"b\";s:17:\"viewAnyPermission\";s:1:\"c\";s:10:\"Permission\";s:1:\"d\";s:6:\"admins\";s:1:\"g\";s:12:\"权限列表\";s:1:\"r\";a:1:{i:0;i:1;}}i:15;a:6:{s:1:\"a\";i:16;s:1:\"b\";s:14:\"viewPermission\";s:1:\"c\";s:10:\"Permission\";s:1:\"d\";s:6:\"admins\";s:1:\"g\";s:12:\"查看权限\";s:1:\"r\";a:1:{i:0;i:1;}}i:16;a:6:{s:1:\"a\";i:17;s:1:\"b\";s:16:\"createPermission\";s:1:\"c\";s:10:\"Permission\";s:1:\"d\";s:6:\"admins\";s:1:\"g\";s:12:\"创建权限\";s:1:\"r\";a:1:{i:0;i:1;}}i:17;a:6:{s:1:\"a\";i:18;s:1:\"b\";s:16:\"updatePermission\";s:1:\"c\";s:10:\"Permission\";s:1:\"d\";s:6:\"admins\";s:1:\"g\";s:12:\"更新权限\";s:1:\"r\";a:1:{i:0;i:1;}}i:18;a:6:{s:1:\"a\";i:19;s:1:\"b\";s:16:\"deletePermission\";s:1:\"c\";s:10:\"Permission\";s:1:\"d\";s:6:\"admins\";s:1:\"g\";s:12:\"删除权限\";s:1:\"r\";a:1:{i:0;i:1;}}i:19;a:6:{s:1:\"a\";i:20;s:1:\"b\";s:17:\"restorePermission\";s:1:\"c\";s:10:\"Permission\";s:1:\"d\";s:6:\"admins\";s:1:\"g\";s:12:\"恢复权限\";s:1:\"r\";a:1:{i:0;i:1;}}i:20;a:6:{s:1:\"a\";i:21;s:1:\"b\";s:21:\"forceDeletePermission\";s:1:\"c\";s:10:\"Permission\";s:1:\"d\";s:6:\"admins\";s:1:\"g\";s:18:\"强制删除权限\";s:1:\"r\";a:1:{i:0;i:1;}}i:21;a:6:{s:1:\"a\";i:22;s:1:\"b\";s:11:\"viewAnyRole\";s:1:\"c\";s:4:\"Role\";s:1:\"d\";s:6:\"admins\";s:1:\"g\";s:12:\"角色列表\";s:1:\"r\";a:1:{i:0;i:1;}}i:22;a:6:{s:1:\"a\";i:23;s:1:\"b\";s:8:\"viewRole\";s:1:\"c\";s:4:\"Role\";s:1:\"d\";s:6:\"admins\";s:1:\"g\";s:12:\"查看角色\";s:1:\"r\";a:1:{i:0;i:1;}}i:23;a:6:{s:1:\"a\";i:24;s:1:\"b\";s:10:\"createRole\";s:1:\"c\";s:4:\"Role\";s:1:\"d\";s:6:\"admins\";s:1:\"g\";s:12:\"创建角色\";s:1:\"r\";a:1:{i:0;i:1;}}i:24;a:6:{s:1:\"a\";i:25;s:1:\"b\";s:10:\"updateRole\";s:1:\"c\";s:4:\"Role\";s:1:\"d\";s:6:\"admins\";s:1:\"g\";s:12:\"更新角色\";s:1:\"r\";a:1:{i:0;i:1;}}i:25;a:6:{s:1:\"a\";i:26;s:1:\"b\";s:10:\"deleteRole\";s:1:\"c\";s:4:\"Role\";s:1:\"d\";s:6:\"admins\";s:1:\"g\";s:12:\"删除角色\";s:1:\"r\";a:1:{i:0;i:1;}}i:26;a:6:{s:1:\"a\";i:27;s:1:\"b\";s:11:\"restoreRole\";s:1:\"c\";s:4:\"Role\";s:1:\"d\";s:6:\"admins\";s:1:\"g\";s:12:\"恢复角色\";s:1:\"r\";a:1:{i:0;i:1;}}i:27;a:6:{s:1:\"a\";i:28;s:1:\"b\";s:15:\"forceDeleteRole\";s:1:\"c\";s:4:\"Role\";s:1:\"d\";s:6:\"admins\";s:1:\"g\";s:18:\"强制删除角色\";s:1:\"r\";a:1:{i:0;i:1;}}i:28;a:6:{s:1:\"a\";i:29;s:1:\"b\";s:11:\"viewAnyUser\";s:1:\"c\";s:4:\"User\";s:1:\"d\";s:6:\"admins\";s:1:\"g\";s:12:\"用户列表\";s:1:\"r\";a:1:{i:0;i:1;}}i:29;a:6:{s:1:\"a\";i:30;s:1:\"b\";s:8:\"viewUser\";s:1:\"c\";s:4:\"User\";s:1:\"d\";s:6:\"admins\";s:1:\"g\";s:12:\"查看用户\";s:1:\"r\";a:1:{i:0;i:1;}}i:30;a:6:{s:1:\"a\";i:31;s:1:\"b\";s:10:\"createUser\";s:1:\"c\";s:4:\"User\";s:1:\"d\";s:6:\"admins\";s:1:\"g\";s:12:\"创建用户\";s:1:\"r\";a:1:{i:0;i:1;}}i:31;a:6:{s:1:\"a\";i:32;s:1:\"b\";s:10:\"updateUser\";s:1:\"c\";s:4:\"User\";s:1:\"d\";s:6:\"admins\";s:1:\"g\";s:12:\"更新用户\";s:1:\"r\";a:1:{i:0;i:1;}}i:32;a:6:{s:1:\"a\";i:33;s:1:\"b\";s:10:\"deleteUser\";s:1:\"c\";s:4:\"User\";s:1:\"d\";s:6:\"admins\";s:1:\"g\";s:12:\"删除用户\";s:1:\"r\";a:1:{i:0;i:1;}}i:33;a:6:{s:1:\"a\";i:34;s:1:\"b\";s:11:\"restoreUser\";s:1:\"c\";s:4:\"User\";s:1:\"d\";s:6:\"admins\";s:1:\"g\";s:12:\"恢复用户\";s:1:\"r\";a:1:{i:0;i:1;}}i:34;a:6:{s:1:\"a\";i:35;s:1:\"b\";s:15:\"forceDeleteUser\";s:1:\"c\";s:4:\"User\";s:1:\"d\";s:6:\"admins\";s:1:\"g\";s:18:\"强制删除用户\";s:1:\"r\";a:1:{i:0;i:1;}}i:35;a:6:{s:1:\"a\";i:36;s:1:\"b\";s:15:\"viewAnySettings\";s:1:\"c\";s:8:\"Settings\";s:1:\"d\";s:6:\"admins\";s:1:\"g\";s:12:\"设置列表\";s:1:\"r\";a:1:{i:0;i:1;}}i:36;a:6:{s:1:\"a\";i:37;s:1:\"b\";s:12:\"viewSettings\";s:1:\"c\";s:8:\"Settings\";s:1:\"d\";s:6:\"admins\";s:1:\"g\";s:12:\"查看设置\";s:1:\"r\";a:1:{i:0;i:1;}}i:37;a:6:{s:1:\"a\";i:38;s:1:\"b\";s:14:\"createSettings\";s:1:\"c\";s:8:\"Settings\";s:1:\"d\";s:6:\"admins\";s:1:\"g\";s:12:\"创建设置\";s:1:\"r\";a:1:{i:0;i:1;}}i:38;a:6:{s:1:\"a\";i:39;s:1:\"b\";s:14:\"updateSettings\";s:1:\"c\";s:8:\"Settings\";s:1:\"d\";s:6:\"admins\";s:1:\"g\";s:12:\"更新设置\";s:1:\"r\";a:1:{i:0;i:1;}}i:39;a:6:{s:1:\"a\";i:40;s:1:\"b\";s:14:\"deleteSettings\";s:1:\"c\";s:8:\"Settings\";s:1:\"d\";s:6:\"admins\";s:1:\"g\";s:12:\"删除设置\";s:1:\"r\";a:1:{i:0;i:1;}}i:40;a:6:{s:1:\"a\";i:41;s:1:\"b\";s:15:\"restoreSettings\";s:1:\"c\";s:8:\"Settings\";s:1:\"d\";s:6:\"admins\";s:1:\"g\";s:12:\"恢复设置\";s:1:\"r\";a:1:{i:0;i:1;}}i:41;a:6:{s:1:\"a\";i:42;s:1:\"b\";s:19:\"forceDeleteSettings\";s:1:\"c\";s:8:\"Settings\";s:1:\"d\";s:6:\"admins\";s:1:\"g\";s:18:\"强制删除设置\";s:1:\"r\";a:1:{i:0;i:1;}}}s:5:\"roles\";a:1:{i:0;a:4:{s:1:\"a\";i:1;s:1:\"b\";s:11:\"super-admin\";s:1:\"d\";s:6:\"admins\";s:1:\"g\";s:15:\"超级管理员\";}}}', 1714188605);
COMMIT;

-- ----------------------------
-- Table structure for cache_locks
-- ----------------------------
DROP TABLE IF EXISTS `cache_locks`;
CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of cache_locks
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for failed_jobs
-- ----------------------------
DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of failed_jobs
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for job_batches
-- ----------------------------
DROP TABLE IF EXISTS `job_batches`;
CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of job_batches
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for jobs
-- ----------------------------
DROP TABLE IF EXISTS `jobs`;
CREATE TABLE `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of jobs
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of migrations
-- ----------------------------
BEGIN;
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (1, '0001_01_01_000000_create_users_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (2, '0001_01_01_000001_create_cache_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (3, '0001_01_01_000002_create_jobs_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (4, '2018_01_01_000000_create_action_events_table', 2);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (5, '2019_05_10_000000_add_fields_to_action_events_table', 2);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (6, '2021_08_25_193039_create_nova_notifications_table', 2);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (7, '2022_04_26_000000_add_fields_to_nova_notifications_table', 2);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (8, '2022_12_19_000000_create_field_attachments_table', 2);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (9, '2024_04_04_210029_create_admin_users_table', 2);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (10, '2024_04_04_210428_create_personal_access_tokens_table', 2);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (11, '2019_08_13_000000_create_nova_settings_table', 3);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (12, '2021_02_15_000000_update_nova_settings_value_column', 3);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (13, '2024_04_04_215956_create_permission_tables', 4);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (14, '2024_04_04_220936_create_activity_log_table', 5);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (15, '2024_04_04_220937_add_event_column_to_activity_log_table', 5);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (16, '2024_04_04_220938_add_batch_uuid_column_to_activity_log_table', 5);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (17, '2024_04_04_215958_add_title_to_permissions_table', 6);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (18, '2024_04_04_215959_add_title_to_roles_table', 6);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (19, '2024_04_04_223831_change_subject_id_to_activity_log_table', 7);
COMMIT;

-- ----------------------------
-- Table structure for model_has_permissions
-- ----------------------------
DROP TABLE IF EXISTS `model_has_permissions`;
CREATE TABLE `model_has_permissions` (
  `permission_id` int unsigned NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of model_has_permissions
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for model_has_roles
-- ----------------------------
DROP TABLE IF EXISTS `model_has_roles`;
CREATE TABLE `model_has_roles` (
  `role_id` int unsigned NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of model_has_roles
-- ----------------------------
BEGIN;
INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES (1, 'App\\Models\\AdminUser', 1);
COMMIT;

-- ----------------------------
-- Table structure for nova_field_attachments
-- ----------------------------
DROP TABLE IF EXISTS `nova_field_attachments`;
CREATE TABLE `nova_field_attachments` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `attachable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `attachable_id` bigint unsigned NOT NULL,
  `attachment` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `disk` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `nova_field_attachments_attachable_type_attachable_id_index` (`attachable_type`,`attachable_id`),
  KEY `nova_field_attachments_url_index` (`url`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of nova_field_attachments
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for nova_notifications
-- ----------------------------
DROP TABLE IF EXISTS `nova_notifications`;
CREATE TABLE `nova_notifications` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_id` bigint unsigned NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `nova_notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of nova_notifications
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for nova_pending_field_attachments
-- ----------------------------
DROP TABLE IF EXISTS `nova_pending_field_attachments`;
CREATE TABLE `nova_pending_field_attachments` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `draft_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `attachment` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `disk` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `nova_pending_field_attachments_draft_id_index` (`draft_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of nova_pending_field_attachments
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for nova_settings
-- ----------------------------
DROP TABLE IF EXISTS `nova_settings`;
CREATE TABLE `nova_settings` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of nova_settings
-- ----------------------------
BEGIN;
INSERT INTO `nova_settings` (`key`, `value`) VALUES ('is_enable', '1');
INSERT INTO `nova_settings` (`key`, `value`) VALUES ('site_name', '1');
INSERT INTO `nova_settings` (`key`, `value`) VALUES ('site_url', '1');
COMMIT;

-- ----------------------------
-- Table structure for password_reset_tokens
-- ----------------------------
DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of password_reset_tokens
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for permissions
-- ----------------------------
DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `group` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标题',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of permissions
-- ----------------------------
BEGIN;
INSERT INTO `permissions` (`id`, `name`, `group`, `guard_name`, `created_at`, `updated_at`, `title`) VALUES (1, 'viewAnyActivity', 'Activity', 'admins', '2024-04-04 22:21:53', '2024-04-04 22:21:53', '操作日志列表');
INSERT INTO `permissions` (`id`, `name`, `group`, `guard_name`, `created_at`, `updated_at`, `title`) VALUES (2, 'viewActivity', 'Activity', 'admins', '2024-04-04 22:21:53', '2024-04-04 22:21:53', '查看操作日志');
INSERT INTO `permissions` (`id`, `name`, `group`, `guard_name`, `created_at`, `updated_at`, `title`) VALUES (3, 'createActivity', 'Activity', 'admins', '2024-04-04 22:21:53', '2024-04-04 22:21:53', '创建操作日志');
INSERT INTO `permissions` (`id`, `name`, `group`, `guard_name`, `created_at`, `updated_at`, `title`) VALUES (4, 'updateActivity', 'Activity', 'admins', '2024-04-04 22:21:53', '2024-04-04 22:21:53', '更新操作日志');
INSERT INTO `permissions` (`id`, `name`, `group`, `guard_name`, `created_at`, `updated_at`, `title`) VALUES (5, 'deleteActivity', 'Activity', 'admins', '2024-04-04 22:21:53', '2024-04-04 22:21:53', '删除操作日志');
INSERT INTO `permissions` (`id`, `name`, `group`, `guard_name`, `created_at`, `updated_at`, `title`) VALUES (6, 'restoreActivity', 'Activity', 'admins', '2024-04-04 22:21:53', '2024-04-04 22:21:53', '恢复操作日志');
INSERT INTO `permissions` (`id`, `name`, `group`, `guard_name`, `created_at`, `updated_at`, `title`) VALUES (7, 'forceDeleteActivity', 'Activity', 'admins', '2024-04-04 22:21:53', '2024-04-04 22:21:53', '强制删除操作日志');
INSERT INTO `permissions` (`id`, `name`, `group`, `guard_name`, `created_at`, `updated_at`, `title`) VALUES (8, 'viewAnyAdminUser', 'AdminUser', 'admins', '2024-04-04 22:21:53', '2024-04-04 22:21:53', '管理员列表');
INSERT INTO `permissions` (`id`, `name`, `group`, `guard_name`, `created_at`, `updated_at`, `title`) VALUES (9, 'viewAdminUser', 'AdminUser', 'admins', '2024-04-04 22:21:53', '2024-04-04 22:21:53', '查看管理员');
INSERT INTO `permissions` (`id`, `name`, `group`, `guard_name`, `created_at`, `updated_at`, `title`) VALUES (10, 'createAdminUser', 'AdminUser', 'admins', '2024-04-04 22:21:53', '2024-04-04 22:21:53', '创建管理员');
INSERT INTO `permissions` (`id`, `name`, `group`, `guard_name`, `created_at`, `updated_at`, `title`) VALUES (11, 'updateAdminUser', 'AdminUser', 'admins', '2024-04-04 22:21:53', '2024-04-04 22:21:53', '更新管理员');
INSERT INTO `permissions` (`id`, `name`, `group`, `guard_name`, `created_at`, `updated_at`, `title`) VALUES (12, 'deleteAdminUser', 'AdminUser', 'admins', '2024-04-04 22:21:53', '2024-04-04 22:21:53', '删除管理员');
INSERT INTO `permissions` (`id`, `name`, `group`, `guard_name`, `created_at`, `updated_at`, `title`) VALUES (13, 'restoreAdminUser', 'AdminUser', 'admins', '2024-04-04 22:21:53', '2024-04-04 22:21:53', '恢复管理员');
INSERT INTO `permissions` (`id`, `name`, `group`, `guard_name`, `created_at`, `updated_at`, `title`) VALUES (14, 'forceDeleteAdminUser', 'AdminUser', 'admins', '2024-04-04 22:21:53', '2024-04-04 22:21:53', '强制删除管理员');
INSERT INTO `permissions` (`id`, `name`, `group`, `guard_name`, `created_at`, `updated_at`, `title`) VALUES (15, 'viewAnyPermission', 'Permission', 'admins', '2024-04-04 22:21:53', '2024-04-04 22:21:53', '权限列表');
INSERT INTO `permissions` (`id`, `name`, `group`, `guard_name`, `created_at`, `updated_at`, `title`) VALUES (16, 'viewPermission', 'Permission', 'admins', '2024-04-04 22:21:53', '2024-04-04 22:21:53', '查看权限');
INSERT INTO `permissions` (`id`, `name`, `group`, `guard_name`, `created_at`, `updated_at`, `title`) VALUES (17, 'createPermission', 'Permission', 'admins', '2024-04-04 22:21:53', '2024-04-04 22:21:53', '创建权限');
INSERT INTO `permissions` (`id`, `name`, `group`, `guard_name`, `created_at`, `updated_at`, `title`) VALUES (18, 'updatePermission', 'Permission', 'admins', '2024-04-04 22:21:53', '2024-04-04 22:21:53', '更新权限');
INSERT INTO `permissions` (`id`, `name`, `group`, `guard_name`, `created_at`, `updated_at`, `title`) VALUES (19, 'deletePermission', 'Permission', 'admins', '2024-04-04 22:21:53', '2024-04-04 22:21:53', '删除权限');
INSERT INTO `permissions` (`id`, `name`, `group`, `guard_name`, `created_at`, `updated_at`, `title`) VALUES (20, 'restorePermission', 'Permission', 'admins', '2024-04-04 22:21:53', '2024-04-04 22:21:53', '恢复权限');
INSERT INTO `permissions` (`id`, `name`, `group`, `guard_name`, `created_at`, `updated_at`, `title`) VALUES (21, 'forceDeletePermission', 'Permission', 'admins', '2024-04-04 22:21:53', '2024-04-04 22:21:53', '强制删除权限');
INSERT INTO `permissions` (`id`, `name`, `group`, `guard_name`, `created_at`, `updated_at`, `title`) VALUES (22, 'viewAnyRole', 'Role', 'admins', '2024-04-04 22:21:53', '2024-04-04 22:21:53', '角色列表');
INSERT INTO `permissions` (`id`, `name`, `group`, `guard_name`, `created_at`, `updated_at`, `title`) VALUES (23, 'viewRole', 'Role', 'admins', '2024-04-04 22:21:53', '2024-04-04 22:21:53', '查看角色');
INSERT INTO `permissions` (`id`, `name`, `group`, `guard_name`, `created_at`, `updated_at`, `title`) VALUES (24, 'createRole', 'Role', 'admins', '2024-04-04 22:21:53', '2024-04-04 22:21:53', '创建角色');
INSERT INTO `permissions` (`id`, `name`, `group`, `guard_name`, `created_at`, `updated_at`, `title`) VALUES (25, 'updateRole', 'Role', 'admins', '2024-04-04 22:21:53', '2024-04-04 22:21:53', '更新角色');
INSERT INTO `permissions` (`id`, `name`, `group`, `guard_name`, `created_at`, `updated_at`, `title`) VALUES (26, 'deleteRole', 'Role', 'admins', '2024-04-04 22:21:53', '2024-04-04 22:21:53', '删除角色');
INSERT INTO `permissions` (`id`, `name`, `group`, `guard_name`, `created_at`, `updated_at`, `title`) VALUES (27, 'restoreRole', 'Role', 'admins', '2024-04-04 22:21:53', '2024-04-04 22:21:53', '恢复角色');
INSERT INTO `permissions` (`id`, `name`, `group`, `guard_name`, `created_at`, `updated_at`, `title`) VALUES (28, 'forceDeleteRole', 'Role', 'admins', '2024-04-04 22:21:53', '2024-04-04 22:21:53', '强制删除角色');
INSERT INTO `permissions` (`id`, `name`, `group`, `guard_name`, `created_at`, `updated_at`, `title`) VALUES (29, 'viewAnyUser', 'User', 'admins', '2024-04-04 22:21:53', '2024-04-04 22:21:53', '用户列表');
INSERT INTO `permissions` (`id`, `name`, `group`, `guard_name`, `created_at`, `updated_at`, `title`) VALUES (30, 'viewUser', 'User', 'admins', '2024-04-04 22:21:53', '2024-04-04 22:21:53', '查看用户');
INSERT INTO `permissions` (`id`, `name`, `group`, `guard_name`, `created_at`, `updated_at`, `title`) VALUES (31, 'createUser', 'User', 'admins', '2024-04-04 22:21:53', '2024-04-04 22:21:53', '创建用户');
INSERT INTO `permissions` (`id`, `name`, `group`, `guard_name`, `created_at`, `updated_at`, `title`) VALUES (32, 'updateUser', 'User', 'admins', '2024-04-04 22:21:53', '2024-04-04 22:21:53', '更新用户');
INSERT INTO `permissions` (`id`, `name`, `group`, `guard_name`, `created_at`, `updated_at`, `title`) VALUES (33, 'deleteUser', 'User', 'admins', '2024-04-04 22:21:53', '2024-04-04 22:21:53', '删除用户');
INSERT INTO `permissions` (`id`, `name`, `group`, `guard_name`, `created_at`, `updated_at`, `title`) VALUES (34, 'restoreUser', 'User', 'admins', '2024-04-04 22:21:53', '2024-04-04 22:21:53', '恢复用户');
INSERT INTO `permissions` (`id`, `name`, `group`, `guard_name`, `created_at`, `updated_at`, `title`) VALUES (35, 'forceDeleteUser', 'User', 'admins', '2024-04-04 22:21:53', '2024-04-04 22:21:53', '强制删除用户');
INSERT INTO `permissions` (`id`, `name`, `group`, `guard_name`, `created_at`, `updated_at`, `title`) VALUES (36, 'viewAnySettings', 'Settings', 'admins', '2024-04-04 22:21:53', '2024-04-04 22:21:53', '设置列表');
INSERT INTO `permissions` (`id`, `name`, `group`, `guard_name`, `created_at`, `updated_at`, `title`) VALUES (37, 'viewSettings', 'Settings', 'admins', '2024-04-04 22:21:53', '2024-04-04 22:21:53', '查看设置');
INSERT INTO `permissions` (`id`, `name`, `group`, `guard_name`, `created_at`, `updated_at`, `title`) VALUES (38, 'createSettings', 'Settings', 'admins', '2024-04-04 22:21:53', '2024-04-04 22:21:53', '创建设置');
INSERT INTO `permissions` (`id`, `name`, `group`, `guard_name`, `created_at`, `updated_at`, `title`) VALUES (39, 'updateSettings', 'Settings', 'admins', '2024-04-04 22:21:53', '2024-04-04 22:21:53', '更新设置');
INSERT INTO `permissions` (`id`, `name`, `group`, `guard_name`, `created_at`, `updated_at`, `title`) VALUES (40, 'deleteSettings', 'Settings', 'admins', '2024-04-04 22:21:53', '2024-04-04 22:21:53', '删除设置');
INSERT INTO `permissions` (`id`, `name`, `group`, `guard_name`, `created_at`, `updated_at`, `title`) VALUES (41, 'restoreSettings', 'Settings', 'admins', '2024-04-04 22:21:53', '2024-04-04 22:21:53', '恢复设置');
INSERT INTO `permissions` (`id`, `name`, `group`, `guard_name`, `created_at`, `updated_at`, `title`) VALUES (42, 'forceDeleteSettings', 'Settings', 'admins', '2024-04-04 22:21:53', '2024-04-04 22:21:53', '强制删除设置');
COMMIT;

-- ----------------------------
-- Table structure for personal_access_tokens
-- ----------------------------
DROP TABLE IF EXISTS `personal_access_tokens`;
CREATE TABLE `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of personal_access_tokens
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for role_has_permissions
-- ----------------------------
DROP TABLE IF EXISTS `role_has_permissions`;
CREATE TABLE `role_has_permissions` (
  `permission_id` int unsigned NOT NULL,
  `role_id` int unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `role_has_permissions_role_id_foreign` (`role_id`),
  CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of role_has_permissions
-- ----------------------------
BEGIN;
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES (1, 1);
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES (2, 1);
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES (3, 1);
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES (4, 1);
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES (5, 1);
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES (6, 1);
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES (7, 1);
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES (8, 1);
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES (9, 1);
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES (10, 1);
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES (11, 1);
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES (12, 1);
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES (13, 1);
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES (14, 1);
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES (15, 1);
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES (16, 1);
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES (17, 1);
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES (18, 1);
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES (19, 1);
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES (20, 1);
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES (21, 1);
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES (22, 1);
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES (23, 1);
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES (24, 1);
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES (25, 1);
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES (26, 1);
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES (27, 1);
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES (28, 1);
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES (29, 1);
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES (30, 1);
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES (31, 1);
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES (32, 1);
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES (33, 1);
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES (34, 1);
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES (35, 1);
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES (36, 1);
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES (37, 1);
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES (38, 1);
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES (39, 1);
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES (40, 1);
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES (41, 1);
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES (42, 1);
COMMIT;

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标题',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of roles
-- ----------------------------
BEGIN;
INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`, `title`) VALUES (1, 'super-admin', 'admins', '2024-04-04 22:21:53', '2024-04-04 22:21:53', '超级管理员');
COMMIT;

-- ----------------------------
-- Table structure for sessions
-- ----------------------------
DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of sessions
-- ----------------------------
BEGIN;
INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES ('EChU5kk3asFwI8CbJtWnk31Ig5ZAP0jUAQyVR4Wm', 1, '192.168.56.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:125.0) Gecko/20100101 Firefox/125.0', 'YTo2OntzOjY6Il90b2tlbiI7czo0MDoiNUF4WHdUeGM2UmV1QnhlU1AyeVhOYXVwQ2c2ekFVb2RORnBlSnYzbSI7czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjU0OiJodHRwczovL2ljb3JlMTEudGVzdC9ub3ZhLWFwaS9zY3JpcHRzL25vdmEtcGVybWlzc2lvbnMiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUzOiJsb2dpbl9hZG1pbnNfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO3M6NDoiYXV0aCI7YToxOntzOjIxOiJwYXNzd29yZF9jb25maXJtZWRfYXQiO2k6MTcxNDEwMjIwNjt9fQ==', 1714103294);
INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES ('rtHXADDE3rGaMYXsNcWwK7XxSngdm1Au1TxmOZdJ', NULL, '192.168.56.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:124.0) Gecko/20100101 Firefox/124.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMGxCT3FYVWJkR3M3V3ZRZGhFYzZjaGx3enlCdUlOUjJCSFR2NzAwYiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vaWNvcmUxMS50ZXN0L2FkbWluL2xvZ2luIjt9fQ==', 1712323717);
INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES ('tt1z6tmCH5McIToWTpiFjqtTSJdOzwdEdN8LnmPj', 1, '192.168.56.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:124.0) Gecko/20100101 Firefox/124.0', 'YTo2OntzOjY6Il90b2tlbiI7czo0MDoiM1VTekd0NG9OdmMycjJEb1d1MVhYeGMzNU12NVVzakp4c1JyZlNwcCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDI6Imh0dHBzOi8vaWNvcmUxMS50ZXN0L2FkbWluL2Rhc2hib2FyZHMvbWFpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6MzoidXJsIjthOjA6e31zOjUzOiJsb2dpbl9hZG1pbnNfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO3M6NDoiYXV0aCI7YToxOntzOjIxOiJwYXNzd29yZF9jb25maXJtZWRfYXQiO2k6MTcxMjIzNzk4ODt9fQ==', 1712242393);
COMMIT;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of users
-- ----------------------------
BEGIN;
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
