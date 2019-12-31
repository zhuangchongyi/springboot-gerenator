/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50646
 Source Host           : localhost:3306
 Source Schema         : mydb

 Target Server Type    : MySQL
 Target Server Version : 50646
 File Encoding         : 65001

 Date: 31/12/2019 13:29:20
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户主键id',
  `username` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名称',
  `password` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户密码',
  `gender` enum('男','女','保密') CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '性别',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '手机号',
  `state` int(1) DEFAULT 0 COMMENT '用户状态/0启用/1禁用',
  `created_id` int(11) DEFAULT NULL COMMENT '创建人id',
  `created_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建人',
  `created_date` timestamp(0) NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `updated_id` int(11) DEFAULT NULL COMMENT '修改人id',
  `updated_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '修改人',
  `updated_date` timestamp(0) NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100005 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统用户表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (100000, 'admin', 'admin', '保密', NULL, 0, NULL, NULL, '2019-12-30 00:00:00', NULL, NULL, '2019-12-31 00:00:00');
INSERT INTO `sys_user` VALUES (100001, '刘备', '123456', '男', NULL, 0, NULL, NULL, '2019-12-30 00:00:00', NULL, NULL, '2019-12-31 00:00:00');
INSERT INTO `sys_user` VALUES (100002, '关羽', '123456', '女', NULL, 0, NULL, NULL, '2019-12-30 00:00:00', NULL, NULL, '2019-12-31 00:00:00');
INSERT INTO `sys_user` VALUES (100003, '张飞', '123456', '女', NULL, 0, NULL, NULL, '2019-12-30 00:00:00', NULL, NULL, '2019-12-31 00:00:00');
INSERT INTO `sys_user` VALUES (100004, '赵云', '123456', '男', NULL, 0, NULL, NULL, '2019-12-29 23:00:59', NULL, NULL, '2019-12-31 11:05:38');

SET FOREIGN_KEY_CHECKS = 1;
