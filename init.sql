-- 美食探店分享社区数据库
-- 数据库名: food_explorer

CREATE DATABASE IF NOT EXISTS `food_explorer` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `food_explorer`;

-- 用户表
CREATE TABLE IF NOT EXISTS `users` (
  `id` VARCHAR(64) NOT NULL COMMENT '用户ID',
  `username` VARCHAR(50) NOT NULL COMMENT '用户名',
  `nickname` VARCHAR(50) NOT NULL COMMENT '昵称',
  `password` VARCHAR(255) NOT NULL COMMENT '密码',
  `avatar` VARCHAR(500) DEFAULT NULL COMMENT '头像',
  `bio` VARCHAR(255) DEFAULT NULL COMMENT '简介',
  `follower_count` INT DEFAULT 0 COMMENT '粉丝数',
  `following_count` INT DEFAULT 0 COMMENT '关注数',
  `note_count` INT DEFAULT 0 COMMENT '笔记数',
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户表';

-- 店铺分类表
CREATE TABLE IF NOT EXISTS `shop_categories` (
  `id` VARCHAR(64) NOT NULL COMMENT '分类ID',
  `name` VARCHAR(50) NOT NULL COMMENT '分类名称',
  `icon` VARCHAR(50) DEFAULT NULL COMMENT '图标',
  `sort` INT DEFAULT 0 COMMENT '排序',
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='店铺分类表';

-- 店铺表
CREATE TABLE IF NOT EXISTS `shops` (
  `id` VARCHAR(64) NOT NULL COMMENT '店铺ID',
  `name` VARCHAR(100) NOT NULL COMMENT '店铺名称',
  `category_id` VARCHAR(64) NOT NULL COMMENT '分类ID',
  `category_name` VARCHAR(50) NOT NULL COMMENT '分类名称',
  `address` VARCHAR(255) NOT NULL COMMENT '地址',
  `lat` DECIMAL(10,6) NOT NULL COMMENT '纬度',
  `lng` DECIMAL(10,6) NOT NULL COMMENT '经度',
  `city` VARCHAR(50) DEFAULT NULL COMMENT '城市',
  `district` VARCHAR(50) DEFAULT NULL COMMENT '区/县',
  `rating` DECIMAL(2,1) DEFAULT 5.0 COMMENT '评分',
  `rating_count` INT DEFAULT 0 COMMENT '评分人数',
  `cover_image` VARCHAR(500) DEFAULT NULL COMMENT '封面图',
  `images` TEXT COMMENT '图片列表(JSON数组)',
  `phone` VARCHAR(20) DEFAULT NULL COMMENT '电话',
  `business_hours` VARCHAR(100) DEFAULT NULL COMMENT '营业时间',
  `avg_price` DECIMAL(10,2) DEFAULT NULL COMMENT '人均价格',
  `note_count` INT DEFAULT 0 COMMENT '笔记数',
  `features` VARCHAR(500) DEFAULT NULL COMMENT '特色标签(JSON数组)',
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_category` (`category_id`),
  KEY `idx_location` (`lat`, `lng`),
  KEY `idx_rating` (`rating`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='店铺表';

-- 笔记表
CREATE TABLE IF NOT EXISTS `notes` (
  `id` VARCHAR(64) NOT NULL COMMENT '笔记ID',
  `user_id` VARCHAR(64) NOT NULL COMMENT '用户ID',
  `shop_id` VARCHAR(64) DEFAULT NULL COMMENT '店铺ID',
  `title` VARCHAR(200) NOT NULL COMMENT '标题',
  `content` TEXT COMMENT '内容',
  `images` TEXT COMMENT '图片列表(JSON数组)',
  `rating` TINYINT DEFAULT 5 COMMENT '评分(1-5)',
  `tags` VARCHAR(500) DEFAULT NULL COMMENT '标签(JSON数组)',
  `lat` DECIMAL(10,6) DEFAULT NULL COMMENT '纬度',
  `lng` DECIMAL(10,6) DEFAULT NULL COMMENT '经度',
  `address` VARCHAR(255) DEFAULT NULL COMMENT '地址',
  `city` VARCHAR(50) DEFAULT NULL COMMENT '城市',
  `district` VARCHAR(50) DEFAULT NULL COMMENT '区/县',
  `like_count` INT DEFAULT 0 COMMENT '点赞数',
  `comment_count` INT DEFAULT 0 COMMENT '评论数',
  `favorite_count` INT DEFAULT 0 COMMENT '收藏数',
  `view_count` INT DEFAULT 0 COMMENT '浏览数',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '是否删除',
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_user` (`user_id`),
  KEY `idx_shop` (`shop_id`),
  KEY `idx_created` (`created_at`),
  KEY `idx_like` (`like_count`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='笔记表';

-- 评论表
CREATE TABLE IF NOT EXISTS `comments` (
  `id` VARCHAR(64) NOT NULL COMMENT '评论ID',
  `note_id` VARCHAR(64) NOT NULL COMMENT '笔记ID',
  `user_id` VARCHAR(64) NOT NULL COMMENT '用户ID',
  `content` TEXT NOT NULL COMMENT '内容',
  `like_count` INT DEFAULT 0 COMMENT '点赞数',
  `is_deleted` TINYINT DEFAULT 0 COMMENT '是否删除',
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_note` (`note_id`),
  KEY `idx_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='评论表';

-- 用户关注表
CREATE TABLE IF NOT EXISTS `user_follows` (
  `id` BIGINT AUTO_INCREMENT COMMENT '主键ID',
  `user_id` VARCHAR(64) NOT NULL COMMENT '用户ID',
  `follow_user_id` VARCHAR(64) NOT NULL COMMENT '关注的用户ID',
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_follow` (`user_id`, `follow_user_id`),
  KEY `idx_user` (`user_id`),
  KEY `idx_follow` (`follow_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户关注表';

-- 笔记点赞表
CREATE TABLE IF NOT EXISTS `note_likes` (
  `id` BIGINT AUTO_INCREMENT COMMENT '主键ID',
  `user_id` VARCHAR(64) NOT NULL COMMENT '用户ID',
  `note_id` VARCHAR(64) NOT NULL COMMENT '笔记ID',
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_note` (`user_id`, `note_id`),
  KEY `idx_note` (`note_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='笔记点赞表';

-- 笔记收藏表
CREATE TABLE IF NOT EXISTS `note_favorites` (
  `id` BIGINT AUTO_INCREMENT COMMENT '主键ID',
  `user_id` VARCHAR(64) NOT NULL COMMENT '用户ID',
  `note_id` VARCHAR(64) NOT NULL COMMENT '笔记ID',
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_note` (`user_id`, `note_id`),
  KEY `idx_note` (`note_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='笔记收藏表';

-- 店铺收藏表
CREATE TABLE IF NOT EXISTS `shop_favorites` (
  `id` BIGINT AUTO_INCREMENT COMMENT '主键ID',
  `user_id` VARCHAR(64) NOT NULL COMMENT '用户ID',
  `shop_id` VARCHAR(64) NOT NULL COMMENT '店铺ID',
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_shop` (`user_id`, `shop_id`),
  KEY `idx_shop` (`shop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='店铺收藏表';

-- 评论点赞表
CREATE TABLE IF NOT EXISTS `comment_likes` (
  `id` BIGINT AUTO_INCREMENT COMMENT '主键ID',
  `user_id` VARCHAR(64) NOT NULL COMMENT '用户ID',
  `comment_id` VARCHAR(64) NOT NULL COMMENT '评论ID',
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_comment` (`user_id`, `comment_id`),
  KEY `idx_comment` (`comment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='评论点赞表';

-- ==================== 初始化数据 ====================

-- 店铺分类
INSERT INTO `shop_categories` (`id`, `name`, `icon`, `sort`) VALUES
('c001', '火锅', '🍲', 1),
('c002', '烧烤', '🍢', 2),
('c003', '日料', '🍣', 3),
('c004', '韩餐', '🍜', 4),
('c005', '西餐', '🍝', 5),
('c006', '甜品', '🍰', 6),
('c007', '咖啡', '☕', 7),
('c008', '快餐', '🍔', 8);

-- 初始用户
INSERT INTO `users` (`id`, `username`, `nickname`, `password`, `avatar`, `bio`, `follower_count`, `following_count`, `note_count`) VALUES
('u001', 'foodie001', '美食探店达人', '123456', 'https://picsum.photos/id/64/100/100', '吃遍全城美食，分享真实体验', 12580, 230, 156),
('u002', 'xiaowang', '吃货小王', '123456', 'https://picsum.photos/id/77/100/100', '唯美食与爱不可辜负', 3420, 156, 89),
('u003', 'beijingmap', '北京美食地图', '123456', 'https://picsum.photos/id/91/100/100', '专注北京本地美食推荐', 56800, 89, 423),
('u004', 'meimei', '探店少女小美', '123456', 'https://picsum.photos/id/65/100/100', '95后女生，带你吃遍大街小巷', 23400, 312, 267);

-- 初始店铺
INSERT INTO `shops` (`id`, `name`, `category_id`, `category_name`, `address`, `lat`, `lng`, `city`, `district`, `rating`, `rating_count`, `cover_image`, `images`, `phone`, `business_hours`, `avg_price`, `note_count`, `features`) VALUES
('s001', '老北京铜锅涮肉', 'c001', '火锅', '北京市朝阳区三里屯路19号', 39.9372, 116.4574, '北京市', '朝阳区', 4.8, 2345, 'https://picsum.photos/id/292/400/300', '["https://picsum.photos/id/292/800/600","https://picsum.photos/id/225/800/600"]', '010-12345678', '11:00-22:00', 128, 156, '["免费停车","有包间","可以刷卡","Wi-Fi"]'),
('s002', '燃鬼拉面', 'c003', '日料', '北京市朝阳区建国路93号万达广场', 39.9123, 116.4678, '北京市', '朝阳区', 4.6, 1890, 'https://picsum.photos/id/287/400/300', '["https://picsum.photos/id/287/800/600"]', '010-87654321', '10:30-21:30', 68, 234, '["Wi-Fi","外卖"]'),
('s003', '甜品工坊', 'c006', '甜品', '北京市朝阳区国贸商城B1层', 39.9089, 116.4598, '北京市', '朝阳区', 4.9, 3200, 'https://picsum.photos/id/291/400/300', '["https://picsum.photos/id/291/800/600","https://picsum.photos/id/431/800/600"]', '010-11112222', '10:00-22:00', 45, 445, '["拍照打卡","闺蜜聚会","Wi-Fi"]'),
('s004', '烧烤部落', 'c002', '烧烤', '北京市朝阳区簋街12号', 39.9456, 116.4234, '北京市', '朝阳区', 4.5, 1560, 'https://picsum.photos/id/488/400/300', '["https://picsum.photos/id/488/800/600"]', '010-33334444', '17:00-02:00', 88, 178, '["深夜营业","朋友聚会","啤酒"]'),
('s005', '星咖啡', 'c007', '咖啡', '北京市朝阳区望京SOHO', 39.9876, 116.4789, '北京市', '朝阳区', 4.3, 890, 'https://picsum.photos/id/431/400/300', '["https://picsum.photos/id/431/800/600"]', '010-55556666', '07:00-22:00', 38, 67, '["Wi-Fi","办公","早餐"]');

-- 初始笔记
INSERT INTO `notes` (`id`, `user_id`, `shop_id`, `title`, `content`, `images`, `rating`, `tags`, `lat`, `lng`, `address`, `city`, `district`, `like_count`, `comment_count`, `favorite_count`, `view_count`) VALUES
('n001', 'u001', 's001', '这家铜锅涮肉绝了！肉质鲜嫩到爆', '今天和朋友来吃这家老北京铜锅涮肉，真的太惊艳了！羊肉都是现切的，下锅几秒钟就熟了，蘸上麻酱料，一口下去幸福感满满。环境也很有老北京的味道，服务也很周到，强烈推荐给大家！', '["https://picsum.photos/id/292/800/800","https://picsum.photos/id/225/800/800","https://picsum.photos/id/326/800/800"]', 5, '["火锅","铜锅涮肉","老北京","必吃"]', 39.9372, 116.4574, '北京市朝阳区三里屯路19号', '北京市', '朝阳区', 1234, 89, 456, 12580),
('n002', 'u002', 's002', '人均70吃到撑的拉面店', '这家拉面店我回购无数次了！汤底是熬了十几个小时的猪骨汤，浓郁鲜香。叉烧肉入口即化，溏心蛋也超级嫩。每次来都吃的干干净净，性价比超高！', '["https://picsum.photos/id/287/800/800"]', 4, '["拉面","日料","性价比高"]', 39.9123, 116.4678, '北京市朝阳区建国路93号万达广场', '北京市', '朝阳区', 567, 45, 234, 8900),
('n003', 'u003', 's003', '女生必去的下午茶甜品店', '发现了一家超适合拍照的甜品店！环境超级ins风，每款甜品都做得很精致。推荐草莓慕斯蛋糕，酸甜可口，一点都不腻。约上小姐妹来这里下午茶，拍拍照聊聊天，完美~', '["https://picsum.photos/id/291/800/800","https://picsum.photos/id/431/800/800","https://picsum.photos/id/1080/800/800","https://picsum.photos/id/1067/800/800"]', 5, '["甜品","下午茶","拍照打卡","闺蜜聚会"]', 39.9089, 116.4598, '北京市朝阳区国贸商城B1层', '北京市', '朝阳区', 3456, 234, 1890, 45600),
('n004', 'u004', 's004', '深夜食堂！撸串喝啤酒的好地方', '晚上和朋友出来撸串，这家烧烤店太赞了！羊肉串烤得外焦里嫩，烤茄子也超级入味。环境很有烟火气，边吃边聊特别有氛围。营业到凌晨两点，夜宵首选！', '["https://picsum.photos/id/488/800/800"]', 4, '["烧烤","夜宵","朋友聚会"]', 39.9456, 116.4234, '北京市朝阳区簋街12号', '北京市', '朝阳区', 890, 67, 345, 15600),
('n005', 'u001', 's005', '打工人续命咖啡推荐', '公司楼下的咖啡店，每天早上必来一杯。拿铁咖啡香浓醇厚，豆子是现磨的，性价比也不错。店内环境安静，偶尔也会来这里办公。推荐给附近的打工人~', '["https://picsum.photos/id/431/800/800"]', 4, '["咖啡","日常","打工人"]', 39.9876, 116.4789, '北京市朝阳区望京SOHO', '北京市', '朝阳区', 234, 23, 89, 4560);

-- 初始评论
INSERT INTO `comments` (`id`, `note_id`, `user_id`, `content`, `like_count`) VALUES
('c001', 'n001', 'u002', '看起来好好吃啊！周末就去打卡', 23),
('c002', 'n001', 'u003', '这家确实不错，我也经常去', 45),
('c003', 'n001', 'u004', '收藏了！请问需要排队吗？', 12),
('c004', 'n003', 'u001', '拍照也太好看了吧！求具体位置', 67);

-- 用户关注关系
INSERT INTO `user_follows` (`user_id`, `follow_user_id`) VALUES
('u001', 'u002'),
('u001', 'u003'),
('u002', 'u001'),
('u003', 'u001'),
('u004', 'u001');