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
DROP TABLE IF EXISTS `input`;
CREATE TABLE `input`  (
  `id` int(11) NOT NULL,
  `jumlah_koin` int(11) NULL DEFAULT NULL,
  `jenis_koin` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `Proses_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_Input_Proses_idx`(`Proses_id`) USING BTREE,
  CONSTRAINT `fk_Input_Proses` FOREIGN KEY (`Proses_id`) REFERENCES `proses` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of Input
-- ----------------------------
INSERT INTO `input` VALUES (1, 69, 'Jenis 1', 1);
INSERT INTO `input` VALUES (2, 85, 'Jenis 2', 1);
INSERT INTO `input` VALUES (3, 72, 'Jenis 3', 1);

-- ----------------------------
-- Table structure for Output
-- ----------------------------
DROP TABLE IF EXISTS `output`;
CREATE TABLE `output`  (
  `id` int(11) NOT NULL,
  `jumlah_koin` int(11) NULL DEFAULT NULL,
  `Proses_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_Output_Proses1_idx`(`Proses_id`) USING BTREE,
  CONSTRAINT `fk_Output_Proses1` FOREIGN KEY (`Proses_id`) REFERENCES `proses` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of Output
-- ----------------------------
INSERT INTO `output` VALUES (1, 105, 1);
INSERT INTO `output` VALUES (2, 121, 1);

-- ----------------------------
-- Table structure for Pivot
-- ----------------------------
DROP TABLE IF EXISTS `pivot`;
CREATE TABLE `pivot`  (
  `id` int(11) NOT NULL,
  `Input_id` int(11) NOT NULL,
  `Output_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_Pivot_Input1_idx`(`Input_id`) USING BTREE,
  INDEX `fk_Pivot_Output1_idx`(`Output_id`) USING BTREE,
  CONSTRAINT `fk_Pivot_Input1` FOREIGN KEY (`Input_id`) REFERENCES `input` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pivot_Output1` FOREIGN KEY (`Output_id`) REFERENCES `output` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of Pivot
-- ----------------------------
INSERT INTO `pivot` VALUES (1, 1, 1);
INSERT INTO `pivot` VALUES (2, 1, 2);
INSERT INTO `pivot` VALUES (3, 2, 1);
INSERT INTO `pivot` VALUES (4, 2, 2);
INSERT INTO `pivot` VALUES (5, 3, 1);
INSERT INTO `pivot` VALUES (6, 3, 2);

-- ----------------------------
-- Table structure for Proses
-- ----------------------------
DROP TABLE IF EXISTS `proses`;
CREATE TABLE `proses`  (
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of Proses
-- ----------------------------
INSERT INTO `proses` VALUES (1);

-- ----------------------------
-- Table structure for Tally
-- ----------------------------
DROP TABLE IF EXISTS `tally`;
CREATE TABLE `tally`  (
  `id` int(11) NOT NULL,
  `jumlah_koin` int(11) NULL DEFAULT NULL,
  `Pivot_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_Tally_Pivot1_idx`(`Pivot_id`) USING BTREE,
  CONSTRAINT `fk_Tally_Pivot1` FOREIGN KEY (`Pivot_id`) REFERENCES `pivot` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of Tally
-- ----------------------------
INSERT INTO `tally` VALUES (1, 7, 1);
INSERT INTO `tally` VALUES (2, 9, 1);
INSERT INTO `tally` VALUES (3, 8, 1);
INSERT INTO `tally` VALUES (4, 9, 1);
INSERT INTO `tally` VALUES (5, 9, 2);
INSERT INTO `tally` VALUES (6, 7, 2);
INSERT INTO `tally` VALUES (7, 5, 2);
INSERT INTO `tally` VALUES (8, 6, 2);
INSERT INTO `tally` VALUES (9, 5, 2);
INSERT INTO `tally` VALUES (10, 9, 3);
INSERT INTO `tally` VALUES (11, 7, 3);
INSERT INTO `tally` VALUES (12, 5, 3);
INSERT INTO `tally` VALUES (13, 6, 3);
INSERT INTO `tally` VALUES (14, 5, 3);
INSERT INTO `tally` VALUES (15, 9, 4);
INSERT INTO `tally` VALUES (16, 10, 4);
INSERT INTO `tally` VALUES (17, 10, 4);
INSERT INTO `tally` VALUES (18, 7, 4);
INSERT INTO `tally` VALUES (19, 7, 4);
INSERT INTO `tally` VALUES (20, 10, 4);
INSERT INTO `tally` VALUES (21, 6, 5);
INSERT INTO `tally` VALUES (22, 7, 5);
INSERT INTO `tally` VALUES (23, 10, 5);
INSERT INTO `tally` VALUES (24, 5, 5);
INSERT INTO `tally` VALUES (25, 6, 5);
INSERT INTO `tally` VALUES (26, 6, 5);
INSERT INTO `tally` VALUES (27, 5, 6);
INSERT INTO `tally` VALUES (28, 9, 6);
INSERT INTO `tally` VALUES (29, 10, 6);
INSERT INTO `tally` VALUES (30, 8, 6);

SET FOREIGN_KEY_CHECKS = 1;
