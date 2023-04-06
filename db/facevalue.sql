/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 80026 (8.0.26)
 Source Host           : localhost:3306
 Source Schema         : facevalue

 Target Server Type    : MySQL
 Target Server Version : 80026 (8.0.26)
 File Encoding         : 65001

 Date: 08/11/2022 23:06:17
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for face
-- ----------------------------
DROP TABLE IF EXISTS `face`;
CREATE TABLE `face`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `age` int NULL DEFAULT NULL,
  `beauty` double NULL DEFAULT NULL,
  `expression` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `gender` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `glasses` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `imgPath` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of face
-- ----------------------------
INSERT INTO `face` VALUES (1, 22, 52.09, 'none', 'male', 'common', 'http://localhost:8080/FaceValueSystem_war_exploded/upload/cfda69ec-ec02-4b2b-ad7d-ef93777b5133_1.jpg');
INSERT INTO `face` VALUES (2, 26, 33.79, 'none', 'male', 'common', 'http://localhost:8080/FaceValueSystem_war_exploded/upload/e5dffbd3-df5e-4dff-978e-96eaf431db09_2.jpg');
INSERT INTO `face` VALUES (3, 23, 80.45, 'none', 'male', 'none', 'http://localhost:8080/FaceValueSystem_war_exploded/upload/071cf1a5-2c80-45bd-b210-bfafa299867f_3.jpg');
INSERT INTO `face` VALUES (6, 28, 13.81, 'smile', 'male', 'none', 'http://localhost:8080/FaceValueSystem_war_exploded/upload/bc1916d1-769d-44ed-b2f8-c14716235c23_微信图片_20210710085557.jpg');
INSERT INTO `face` VALUES (7, 48, 22.69, 'smile', 'male', 'none', 'http://localhost:8080/FaceValueSystem_war_exploded/upload/ccf07bab-d3b4-4407-a84b-97f7e950f599_微信图片_20210710085608.jpg');
INSERT INTO `face` VALUES (8, 23, 47.12, 'none', 'male', 'common', 'http://localhost:8080/FaceValueSystem_war_exploded/upload/5761da8e-482a-4b0a-bf30-7b35e0ce15f7_maohua.jpg');
INSERT INTO `face` VALUES (9, 36, 40.39, 'none', 'male', 'none', 'http://localhost:8080/FaceValueSystem_war_exploded/upload/89c108e9-f813-4bab-a58a-6d85b81e2ae0_微信图片_20210710085605.jpg');
INSERT INTO `face` VALUES (10, 36, 40.39, 'none', 'male', 'none', 'http://localhost:8080/FaceValueSystem_war_exploded/upload/cfb35cf6-6f40-48bb-ab5f-bde04d19f005_微信图片_20210710085605.jpg');
INSERT INTO `face` VALUES (11, 22, 44.96, 'none', 'male', 'common', 'http://localhost:8080/FaceValueSystem_war_exploded/upload/5c6389b7-81d5-4c77-af5f-59d898c292b1_112.jpg');

-- ----------------------------
-- Table structure for team
-- ----------------------------
DROP TABLE IF EXISTS `team`;
CREATE TABLE `team`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `score` float NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of team
-- ----------------------------
INSERT INTO `team` VALUES (1, 'team1', 59.23);
INSERT INTO `team` VALUES (2, 'team2', 43.22);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `password` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `imgpath` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id` ASC) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 54 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '秦宇宁', '0fdmdU1qM7', NULL);
INSERT INTO `user` VALUES (2, '顾嘉伦', 'xF9zQgQxF4', NULL);
INSERT INTO `user` VALUES (3, '孙嘉伦', '9sVbkovRx3', NULL);
INSERT INTO `user` VALUES (4, '韩嘉伦', 'MC9STRuJnI', NULL);
INSERT INTO `user` VALUES (5, '邓秀英', 'iYCBLt54dr', NULL);
INSERT INTO `user` VALUES (6, '贺岚', 'sqd24ldqe5', NULL);
INSERT INTO `user` VALUES (7, '宋璐', 'fAna0jfq23', NULL);
INSERT INTO `user` VALUES (8, '侯震南', 'wjLnV3IFs3', NULL);
INSERT INTO `user` VALUES (9, '高杰宏', '1E656DewEv', NULL);
INSERT INTO `user` VALUES (10, '莫安琪', '08UpY9JXTR', NULL);
INSERT INTO `user` VALUES (11, '魏子异', '3uN3VoFNWw', NULL);
INSERT INTO `user` VALUES (12, '陈云熙', '6Rk3CxoLn2', NULL);
INSERT INTO `user` VALUES (13, '雷璐', 'ult8h9QbRA', NULL);
INSERT INTO `user` VALUES (14, '邹璐', '0zGjaMnouV', NULL);
INSERT INTO `user` VALUES (15, '武子异', 'RfFhJ5DKr3', NULL);
INSERT INTO `user` VALUES (16, '莫子异', 'NkHC7pebWd', NULL);
INSERT INTO `user` VALUES (17, '程岚', '9pZoMcdXpK', NULL);
INSERT INTO `user` VALUES (18, '周璐', 'O9sqg87qku', NULL);
INSERT INTO `user` VALUES (19, '武宇宁', 'c9zSUrLsgC', NULL);
INSERT INTO `user` VALUES (20, '蔡子韬', 'ZsQaltch7S', NULL);
INSERT INTO `user` VALUES (21, '杨震南', 'xzKtFiSIjj', NULL);
INSERT INTO `user` VALUES (22, '何宇宁', 'i7HO0jCB5t', NULL);
INSERT INTO `user` VALUES (23, '韦嘉伦', '8ftmLEgeKD', NULL);
INSERT INTO `user` VALUES (24, '石詩涵', 'v4HckmzxIe', NULL);
INSERT INTO `user` VALUES (25, '谭璐', 'FlGPEKRLZp', NULL);
INSERT INTO `user` VALUES (26, '雷嘉伦', 'UkreS4OSUj', NULL);
INSERT INTO `user` VALUES (27, '梁嘉伦', 'rnqFKr6QDm', NULL);
INSERT INTO `user` VALUES (28, '孟云熙', 'wS4SxuemwK', NULL);
INSERT INTO `user` VALUES (29, '魏詩涵', 'Xa2cerSTIT', NULL);
INSERT INTO `user` VALUES (30, '苏安琪', '4vz8uEBcnZ', NULL);
INSERT INTO `user` VALUES (31, '雷詩涵', 't1lGYhEW9F', NULL);
INSERT INTO `user` VALUES (32, '范秀英', 'tBbYJ0uhF2', NULL);
INSERT INTO `user` VALUES (33, '傅致远', 'AerPTubwpn', NULL);
INSERT INTO `user` VALUES (34, '龚子异', '4BYs20mfmn', NULL);
INSERT INTO `user` VALUES (35, '陶詩涵', 'NCiufZzoJA', NULL);
INSERT INTO `user` VALUES (36, '武詩涵', 'cbDTDIxKC9', NULL);
INSERT INTO `user` VALUES (37, '于宇宁', 'IyPw4vgbfn', NULL);
INSERT INTO `user` VALUES (38, '钱岚', 'gvYFeMM60e', NULL);
INSERT INTO `user` VALUES (39, '顾云熙', 'mPlyIOQ8qT', NULL);
INSERT INTO `user` VALUES (40, '黎秀英', '7qs4VNiHOE', NULL);
INSERT INTO `user` VALUES (41, '傅云熙', 'XyrQpkp8TH', NULL);
INSERT INTO `user` VALUES (42, '王璐', 'eT9XNsAu08', NULL);
INSERT INTO `user` VALUES (43, '汪詩涵', 'oBPHkySTFp', NULL);
INSERT INTO `user` VALUES (44, '向致远', 'mJ7JRnoLM6', NULL);
INSERT INTO `user` VALUES (45, '董晓明', 'YpI4Bwy3Mt', NULL);
INSERT INTO `user` VALUES (46, '董杰宏', 'GerM8O1E1T', NULL);
INSERT INTO `user` VALUES (47, '黄云熙', '3jjHV3Tdtf', NULL);
INSERT INTO `user` VALUES (48, '邵杰宏', 'HvEmE6MHFU', NULL);
INSERT INTO `user` VALUES (49, '汤詩涵', 'j5C0HwzkoD', NULL);
INSERT INTO `user` VALUES (50, '杨安琪', 'u3MiK0COl1', NULL);
INSERT INTO `user` VALUES (51, 'luohongyun', '12345678', 'D:\\javaWeb\\FaceValueSystem\\out\\artifacts\\FaceValueSystem_war_exploded\\upload\\user\\luohongyun.jpg');
INSERT INTO `user` VALUES (52, 'lhy', '11222232', NULL);
INSERT INTO `user` VALUES (53, 'lzh', '123456', NULL);

SET FOREIGN_KEY_CHECKS = 1;
