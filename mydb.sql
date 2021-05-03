/*
 Navicat Premium Data Transfer

 Source Server         : EMI ON
 Source Server Type    : MySQL
 Source Server Version : 50734
 Source Host           : 51.79.161.202:3306
 Source Schema         : mydb

 Target Server Type    : MySQL
 Target Server Version : 50734
 File Encoding         : 65001

 Date: 03/05/2021 16:39:07
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for Input
-- ----------------------------
DROP TABLE IF EXISTS `Input`;
CREATE TABLE `Input`  (
  `id` int(11) NOT NULL,
  `jumlah_koin` int(11) NULL DEFAULT NULL,
  `jenis_koin` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `Proses_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_Input_Proses_idx`(`Proses_id`) USING BTREE,
  CONSTRAINT `fk_Input_Proses` FOREIGN KEY (`Proses_id`) REFERENCES `Proses` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of Input
-- ----------------------------
INSERT INTO `Input` VALUES (1, 69, 'Jenis 1', 1);
INSERT INTO `Input` VALUES (2, 85, 'Jenis 2', 1);
INSERT INTO `Input` VALUES (3, 72, 'Jenis 3', 1);

-- ----------------------------
-- Table structure for Output
-- ----------------------------
DROP TABLE IF EXISTS `Output`;
CREATE TABLE `Output`  (
  `id` int(11) NOT NULL,
  `jumlah_koin` int(11) NULL DEFAULT NULL,
  `Proses_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_Output_Proses1_idx`(`Proses_id`) USING BTREE,
  CONSTRAINT `fk_Output_Proses1` FOREIGN KEY (`Proses_id`) REFERENCES `Proses` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of Output
-- ----------------------------
INSERT INTO `Output` VALUES (1, 105, 1);
INSERT INTO `Output` VALUES (2, 121, 1);

-- ----------------------------
-- Table structure for Pivot
-- ----------------------------
DROP TABLE IF EXISTS `Pivot`;
CREATE TABLE `Pivot`  (
  `id` int(11) NOT NULL,
  `Input_id` int(11) NOT NULL,
  `Output_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_Pivot_Input1_idx`(`Input_id`) USING BTREE,
  INDEX `fk_Pivot_Output1_idx`(`Output_id`) USING BTREE,
  CONSTRAINT `fk_Pivot_Input1` FOREIGN KEY (`Input_id`) REFERENCES `Input` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pivot_Output1` FOREIGN KEY (`Output_id`) REFERENCES `Output` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of Pivot
-- ----------------------------
INSERT INTO `Pivot` VALUES (1, 1, 1);
INSERT INTO `Pivot` VALUES (2, 1, 2);
INSERT INTO `Pivot` VALUES (3, 2, 1);
INSERT INTO `Pivot` VALUES (4, 2, 2);
INSERT INTO `Pivot` VALUES (5, 3, 1);
INSERT INTO `Pivot` VALUES (6, 3, 2);

-- ----------------------------
-- Table structure for Proses
-- ----------------------------
DROP TABLE IF EXISTS `Proses`;
CREATE TABLE `Proses`  (
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of Proses
-- ----------------------------
INSERT INTO `Proses` VALUES (1);

-- ----------------------------
-- Table structure for Tally
-- ----------------------------
DROP TABLE IF EXISTS `Tally`;
CREATE TABLE `Tally`  (
  `id` int(11) NOT NULL,
  `jumlah_koin` int(11) NULL DEFAULT NULL,
  `Pivot_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_Tally_Pivot1_idx`(`Pivot_id`) USING BTREE,
  CONSTRAINT `fk_Tally_Pivot1` FOREIGN KEY (`Pivot_id`) REFERENCES `Pivot` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of Tally
-- ----------------------------
INSERT INTO `Tally` VALUES (1, 7, 1);
INSERT INTO `Tally` VALUES (2, 9, 1);
INSERT INTO `Tally` VALUES (3, 8, 1);
INSERT INTO `Tally` VALUES (4, 9, 1);
INSERT INTO `Tally` VALUES (5, 9, 2);
INSERT INTO `Tally` VALUES (6, 7, 2);
INSERT INTO `Tally` VALUES (7, 5, 2);
INSERT INTO `Tally` VALUES (8, 6, 2);
INSERT INTO `Tally` VALUES (9, 5, 2);
INSERT INTO `Tally` VALUES (10, 9, 3);
INSERT INTO `Tally` VALUES (11, 7, 3);
INSERT INTO `Tally` VALUES (12, 5, 3);
INSERT INTO `Tally` VALUES (13, 6, 3);
INSERT INTO `Tally` VALUES (14, 5, 3);
INSERT INTO `Tally` VALUES (15, 9, 4);
INSERT INTO `Tally` VALUES (16, 10, 4);
INSERT INTO `Tally` VALUES (17, 10, 4);
INSERT INTO `Tally` VALUES (18, 7, 4);
INSERT INTO `Tally` VALUES (19, 7, 4);
INSERT INTO `Tally` VALUES (20, 10, 4);
INSERT INTO `Tally` VALUES (21, 6, 5);
INSERT INTO `Tally` VALUES (22, 7, 5);
INSERT INTO `Tally` VALUES (23, 10, 5);
INSERT INTO `Tally` VALUES (24, 5, 5);
INSERT INTO `Tally` VALUES (25, 6, 5);
INSERT INTO `Tally` VALUES (26, 6, 5);
INSERT INTO `Tally` VALUES (27, 5, 6);
INSERT INTO `Tally` VALUES (28, 9, 6);
INSERT INTO `Tally` VALUES (29, 10, 6);
INSERT INTO `Tally` VALUES (30, 8, 6);

SET FOREIGN_KEY_CHECKS = 1;
