-- 数据的准备
	-- 创建一个数据库
	create database python_test charset=utf8;

	-- 使用一个数据库
	use python_test;

	-- 显示使用的当前数据是哪个?
	select database();

	-- 创建一个数据表
	-- students表
	create table students(
	    id int unsigned primary key auto_increment not null,
	    name varchar(20) default '',
	    age tinyint unsigned default 0,
	    height decimal(5,2),
	    gender enum('男','女','中性','保密') default '保密',
	    cls_id int unsigned default 0,
	    is_delete bit default 0
	);

	-- classes表
	create table classes (
	    id int unsigned auto_increment primary key not null,
	    name varchar(30) not null
	);



-- 查询
	-- 查询所有字段
	-- select * from 表名;
	select * from students;
	select * from classes;
	select id, name from classes;

	-- 查询指定字段
	-- select 列1,列2,... from 表名;
	select name, age from students;
	
	-- 使用 as 给字段起别名
	-- select 字段 as 名字.... from 表名;
	select name as 姓名, age as 年龄 from students;

	-- select 表名.字段 .... from 表名;
	select students.name, students.age from students;

	
	-- 可以通过 as 给表起别名
	-- select 别名.字段 .... from 表名 as 别名;
	select students.name, students.age from students;
	select s.name, s.age from students as s;
	-- 失败的select students.name, students.age from students as s;


	-- 消除重复行
	-- distinct 字段
	select distinct gender from students;


-- 条件查询
	-- 比较运算符
		-- select .... from 表名 where .....
		-- >
		-- 查询大于18岁的信息
		select * from students where age>18;
		select id,name,gender from students where age>18;

		-- <
		-- 查询小于18岁的信息
		select * from students where age<18;

		-- >=
		-- <=
		-- 查询小于或者等于18岁的信息

		-- =
		-- 查询年龄为18岁的所有学生的名字
		select * from students where age=18;


		-- != 或者 <>


	-- 逻辑运算符
		-- and
		-- 18到28之间的所以学生信息
		select * from students where age>18 and age<28;
		-- 失败select * from students where age>18 and <28;


		-- 18岁以上的女性
		select * from students where age>18 and gender="女";
		select * from students where age>18 and gender=2;


		-- or
		-- 18以上或者身高查过180(包含)以上
		select * from students where age>18 or height>=180;


		-- not
		-- 不在 18岁以上的女性 这个范围内的信息
		-- select * from students where not age>18 and gender=2;
		select * from students where not (age>18 and gender=2);

		-- 年龄不是小于或者等于18 并且是女性
		select * from students where (not age<=18) and gender=2;


	-- 模糊查询
		-- like 
		-- % 替换1个或者多个
		-- _ 替换1个
		-- 查询姓名中 以 "小" 开始的名字
		select name from students where name="小";
		select name from students where name like "小%";

		-- 查询姓名中 有 "小" 所有的名字
		select name from students where name like "%小%";

		-- 查询有2个字的名字
		select name from students where name like "__";

		-- 查询有3个字的名字
		select name from students where name like "__";

		-- 查询至少有2个字的名字
		select name from students where name like "__%";


		-- rlike 正则
		-- 查询以 周开始的姓名
		select name from students where name rlike "^周.*";

		-- 查询以 周开始、伦结尾的姓名
		select name from students where name rlike "^周.*伦$";


	-- 范围查询
		-- in (1, 3, 8)表示在一个非连续的范围内
		-- 查询 年龄为18、34的姓名
		select name,age from students where age=18 or age=34;
		select name,age from students where age=18 or age=34 or age=12;
		select name,age from students where age in (12, 18, 34);


		
		-- not in 不非连续的范围之内
		-- 年龄不是 18、34岁之间的信息
		select name,age from students where age not in (12, 18, 34);


		-- between ... and ...表示在一个连续的范围内
		-- 查询 年龄在18到34之间的的信息
		select name, age from students where age between 18 and 34;

		
		-- not between ... and ...表示不在一个连续的范围内
		-- 查询 年龄不在在18到34之间的的信息
		select * from students where age not between 18 and 34;
		select * from students where not age between 18 and 34;
		-- 失败的select * from students where age not (between 18 and 34);


	-- 空判断
		-- 判空is null
		-- 查询身高为空的信息
		select * from students where height is null;
		select * from students where height is NULL;
		select * from students where height is Null;

		-- 判非空is not null
		select * from students where height is not null;



-- 排序
	-- order by 字段
	-- 默认主键asc排序
	-- asc从小到大排列，即升序
	-- desc从大到小排序，即降序

	-- 查询年龄在18到34岁之间的男性，按照年龄从小到到排序
	select * from students where (age between 18 and 34) and gender=1;
	select * from students where (age between 18 and 34) and gender=1 order by age;
	select * from students where (age between 18 and 34) and gender=1 order by age asc;


	-- 查询年龄在18到34岁之间的女性，身高从高到矮排序
	select * from students where (age between 18 and 34) and gender=2 order by height desc;
	

	-- order by 多个字段
	-- 查询年龄在18到34岁之间的女性，身高从高到矮排序, 如果身高相同的情况下按照年龄从小到大排序
	select * from students where (age between 18 and 34) and gender=2 order by height desc,id desc;


	-- 查询年龄在18到34岁之间的女性，身高从高到矮排序, 如果身高相同的情况下按照年龄从小到大排序,
	-- 如果年龄也相同那么按照id从大到小排序
	select * from students where (age between 18 and 34) and gender=2 order by height desc,age asc,id desc;

	
	-- 按照年龄从小到大、身高从高到矮的排序
	select * from students order by age asc, height desc;



-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------

-- 聚合函数
	-- 总数
	-- count
	-- 查询男性有多少人，女性有多少人
	select * from students where gender=1;
	select count(*) from students where gender=1;
	select count(*) as 男性人数 from students where gender=1;
	select count(*) as 女性人数 from students where gender=2;


	-- 最大值
	-- max
	-- 查询最大的年龄
	select age from students;
	select max(age) from students;

	-- 查询女性的最高 身高
	select max(height) from students where gender=2;

	-- 最小值
	-- min

	
	-- 求和
	-- sum
	-- 计算所有人的年龄总和
	select sum(age) from students;

	
	-- 平均值
	-- avg
	-- 计算平均年龄
	select avg(age) from students;


	-- 计算平均年龄 sum(age)/count(*)
	select sum(age)/count(*) from students;


	-- 四舍五入 round(123.23 , 1) 保留1位小数
	-- 计算所有人的平均年龄，保留2位小数
	select round(sum(age)/count(*), 2) from students;
	select round(sum(age)/count(*), 3) from students;

	-- 计算男性的平均身高 保留2位小数
	select round(avg(height), 2) from students where gender=1;
	-- select name, round(avg(height), 2) from students where gender=1;

-- 分组

	-- group by: 把原来的数据先分成组, 然后在组里面取(整理\统计等)数据
	-- distinct: 从数据表里面拿到数据直接去重, 没有其他的功能
	-- 按照性别分组,查询所有的性别
	
	-- 失败: select name from students group by gender;
	-- 失败: select * from students group by gender;
	-- 应该取每组都相同的值 
	select gender from students group by gender;

	-- 计算每种性别中的人数
	select gender,count(*) from students group by gender;


	-- 计算男性的人数
	select gender,count(*) from students where gender=1 group by gender;


	-- group_concat(字段名)可以作为一个输出字段来使用
	-- 表示分组之后，根据分组结果，使用group_concat()来放置每一组的某字段的值的集合
	-- 查询同种性别中的姓名
 	select gender,group_concat(name) from students where gender=1 group by gender;
 	select genage, id) from students where gender=1 group by gender;
 	select gender,group_concat(name, "_", age, " ", id) from students where gender=1 group by gender;


	-- having：	对查出来的结果进行判断, 从结果里取东西
	-- where：	对表进行判断
	-- having 条件表达式：用来分组查询后指定一些条件来输出查询结果
	-- having作用和where一样，但having只能用于group by

	-- 查询平均年龄超过30岁的性别，以及姓名 having avg(age) > 30
	select gender, group_concat(name),avg(age) from students group by gender having avg(age)>30;
	
	-- 查询（每种性别中多于2人）的信息
	select gender, group_concat(name) from students group by gender having count(*)>2;


-- =====================================================================================================================
-- 分页
	-- limit start, count

	-- 限制查询出来的数据个数
	select * from students where gender=1 limit 2;

	-- 查询前5个数据
	select * from students limit 0, 5;

	-- 查询id6-10（包含）的书序
	select * from students limit 5, 5;


	-- 每页显示2个，第1个页面
	select * from students limit 0,2;

	-- 每页显示2个，第2个页面
	select * from students limit 2,2;

	-- 每页显示2个，第3个页面
	select * from students limit 4,2;

	-- 每页显示2个，第4个页面
	select * from students limit 6,2; -- -----> limit (第N页-1)*每个的个数, 每页的个数;

	-- 每页显示2个，显示第6页的信息, 按照年龄从小到大排序
	-- 失败select * from students limit 2*(6-1),2;
	-- 失败select * from students limit 10,2 order by age asc;
	select * from students order by age asc limit 10,2;

	select * from students where gender=2 order by height desc limit 0,2;

-- =============================================================================================================

-- 连接查询
	-- 多个表查询数据
	-- 一个表的外键, 就是另一个表的主键; 要用约束的方式说他是一个外键, 否则只是一个字段.
	-- 外键的作用: 限制数据的范围, 一定是要在主键里有, 否则就不对.
	-- 内连接: 取交集
	-- inner join ... on

	-- select ... from 表A inner join 表B;
	select * from students inner join classes;
	-- 把表A中的每条记录, 都取了表B的所有数据, 乱了
+----+-----------+------+--------+--------+--------+-----------+----+-------------+
| id | name      | age  | height | gender | cls_id | is_delete | id | name        |
+----+-----------+------+--------+--------+--------+-----------+----+-------------+
|  1 | 小明      |   18 | 180.00 | 女     |      1 |           |  1 | Python01期  |
|  1 | 小明      |   18 | 180.00 | 女     |      1 |           |  2 | Python02期  |
|  1 | 小明      |   18 | 180.00 | 女     |      1 |           |  3 | Python04期  |
|  2 | 小月月    |   18 | 180.00 | 女     |      2 |          |  1 | Python01期  |
|  2 | 小月月    |   18 | 180.00 | 女     |      2 |          |  2 | Python02期  |
|  2 | 小月月    |   18 | 180.00 | 女     |      2 |          |  3 | Python04期  |
|  3 | 彭于晏    |   29 | 185.00 | 男     |      1 |           |  1 | Python01期  |
|  3 | 彭于晏    |   29 | 185.00 | 男     |      1 |           |  2 | Python02期  |
|  3 | 彭于晏    |   29 | 185.00 | 男     |      1 |           |  3 | Python04期  |
|  4 | 刘德华    |   59 | 175.00 | 男     |      2 |          |  1 | Python01期  |
|  4 | 刘德华    |   59 | 175.00 | 男     |      2 |          |  2 | Python02期  |
|  4 | 刘德华    |   59 | 175.00 | 男     |      2 |          |  3 | Python04期  |
|  5 | 黄蓉      |   38 | 160.00 | 女     |      1 |           |  1 | Python01期  |
|  5 | 黄蓉      |   38 | 160.00 | 女     |      1 |           |  2 | Python02期  |
|  5 | 黄蓉      |   38 | 160.00 | 女     |      1 |           |  3 | Python04期  |
|  6 | 凤姐      |   28 | 150.00 | 保密   |      2 |          |  1 | Python01期  |
|  6 | 凤姐      |   28 | 150.00 | 保密   |      2 |          |  2 | Python02期  |
|  6 | 凤姐      |   28 | 150.00 | 保密   |      2 |          |  3 | Python04期  |
|  7 | 王祖贤    |   18 | 172.00 | 女     |      1 |          |  1 | Python01期  |
|  7 | 王祖贤    |   18 | 172.00 | 女     |      1 |          |  2 | Python02期  |
|  7 | 王祖贤    |   18 | 172.00 | 女     |      1 |          |  3 | Python04期  |
|  8 | 周杰伦    |   36 |   NULL | 男     |      1 |           |  1 | Python01期  |
|  8 | 周杰伦    |   36 |   NULL | 男     |      1 |           |  2 | Python02期  |
|  8 | 周杰伦    |   36 |   NULL | 男     |      1 |           |  3 | Python04期  |
|  9 | 程坤      |   27 | 181.00 | 男     |      2 |           |  1 | Python01期  |
|  9 | 程坤      |   27 | 181.00 | 男     |      2 |           |  2 | Python02期  |
|  9 | 程坤      |   27 | 181.00 | 男     |      2 |           |  3 | Python04期  |
| 10 | 刘亦菲    |   25 | 166.00 | 女     |      2 |           |  1 | Python01期  |
| 10 | 刘亦菲    |   25 | 166.00 | 女     |      2 |           |  2 | Python02期  |
| 10 | 刘亦菲    |   25 | 166.00 | 女     |      2 |           |  3 | Python04期  |
| 11 | 金星      |   33 | 162.00 | 中性   |      3 |          |  1 | Python01期  |
| 11 | 金星      |   33 | 162.00 | 中性   |      3 |          |  2 | Python02期  |
| 11 | 金星      |   33 | 162.00 | 中性   |      3 |          |  3 | Python04期  |
| 12 | 静香      |   12 | 180.00 | 女     |      4 |           |  1 | Python01期  |
| 12 | 静香      |   12 | 180.00 | 女     |      4 |           |  2 | Python02期  |
| 12 | 静香      |   12 | 180.00 | 女     |      4 |           |  3 | Python04期  |
| 13 | 郭靖      |   12 | 170.00 | 男     |      4 |           |  1 | Python01期  |
| 13 | 郭靖      |   12 | 170.00 | 男     |      4 |           |  2 | Python02期  |
| 13 | 郭靖      |   12 | 170.00 | 男     |      4 |           |  3 | Python04期  |
| 14 | 周杰      |   34 | 176.00 | 女     |      5 |           |  1 | Python01期  |
| 14 | 周杰      |   34 | 176.00 | 女     |      5 |           |  2 | Python02期  |
| 14 | 周杰      |   34 | 176.00 | 女     |      5 |           |  3 | Python04期  |
+----+-----------+------+--------+--------+--------+-----------+----+-------------+




	-- 查询 有能够对应班级的学生以及班级信息
	select * from students inner join classes on students.cls_id=classes.id;
	-- 数据A取出来, 能与数据B对应上, students表里面的cls_id字段 与 classes表里面的字段对应(都显示); 如果不显示, 就没有输出结果

+----+-----------+------+--------+--------+--------+-----------+----+-------------+
| id | name      | age  | height | gender | cls_id | is_delete | id | name        |
+----+-----------+------+--------+--------+--------+-----------+----+-------------+
|  1 | 小明      |   18 | 180.00 | 女     |      1 |           |  1 | Python01期  |
|  2 | 小月月    |   18 | 180.00 | 女     |      2 |          |  2 | Python02期  |
|  3 | 彭于晏    |   29 | 185.00 | 男     |      1 |           |  1 | Python01期  |
|  4 | 刘德华    |   59 | 175.00 | 男     |      2 |          |  2 | Python02期  |
|  5 | 黄蓉      |   38 | 160.00 | 女     |      1 |           |  1 | Python01期  |
|  6 | 凤姐      |   28 | 150.00 | 保密   |      2 |          |  2 | Python02期  |
|  7 | 王祖贤    |   18 | 172.00 | 女     |      1 |          |  1 | Python01期  |
|  8 | 周杰伦    |   36 |   NULL | 男     |      1 |           |  1 | Python01期  |
|  9 | 程坤      |   27 | 181.00 | 男     |      2 |           |  2 | Python02期  |
| 10 | 刘亦菲    |   25 | 166.00 | 女     |      2 |           |  2 | Python02期  |
| 11 | 金星      |   33 | 162.00 | 中性   |      3 |          |  3 | Python04期  |
+----+-----------+------+--------+--------+--------+-----------+----+-------------+








	-- 按照要求显示姓名、班级
	select students.*, classes.name from students inner join classes on students.cls_id=classes.id;
	select students.name, classes.name from students inner join classes on students.cls_id=classes.id;

	-- 给数据表起名字
	select s.name, c.name from students as s inner join classes as c on s.cls_id=c.id;

	-- 查询 有能够对应班级的学生以及班级信息，显示学生的所有信息，只显示班级名称
	select s.*, c.name from students as s inner join classes as c on s.cls_id=c.id;
	
	-- 在以上的查询中，将班级姓名显示在第1列
	select c.name, s.* from students as s inner join classes as c on s.cls_id=c.id;

	-- 查询 有能够对应班级的学生以及班级信息, 按照班级进行排序
	-- select c.xxx s.xxx from student as s inner join clssses as c on .... order by ....;
	select c.name, s.* from students as s inner join classes as c on s.cls_id=c.id order by c.name;

	-- 当时同一个班级的时候，按照学生的id进行从小到大排序
	select c.name, s.* from students as s inner join classes as c on s.cls_id=c.id order by c.name,s.id;

	-- left join 																	A集合 B集合
	-- 谁写在left join的左边就以谁为基准, 找到就显示, 找不到就显示null					left join  A+AnB
	-- inner join则是两个表的交集														inner join  AuB
	-- 查询每位学生对应的班级信息														left join 	AuB+B
	select * from students as s left join classes as c on s.cls_id=c.id;


	-- 查询没有对应班级信息的学生
	-- select ... from xxx as s left join xxx as c on..... where .....
	-- select ... from xxx as s left join xxx as c on..... having .....
	select * from students as s left join classes as c on s.cls_id=c.id having c.id is null;
	select * from students as s left join classes as c on s.cls_id=c.id where c.id is null;

	-- right join   on
	-- 将数据表名字互换位置，用left join完成, 用得少


-- =============================================================================================
-- 自关联
	-- 省级联动 url:http://demo.lanrenzhijia.com/2014/city0605/

	-- 查询所有省份
	select * from areas where pid is null;

	-- 查询出山东省有哪些市
	select * from areas as province inner join areas as city on city.pid=province.aid having province.atitle="山东省";
	select province.atitle, city.atitle from areas as province inner join areas as city on city.pid=province.aid having province.atitle="山东省";

	-- 查询出青岛市有哪些县城
	select province.atitle, city.atitle from areas as province inner join areas as city on city.pid=province.aid having province.atitle="青岛市";
	select * from areas where pid=(select aid from areas where atitle="青岛市")


-- 子查询
	-- 标量子查询
	-- 查询出高于平均身高的信息

	-- 查询最高的男生信息
	select * from students where height = 188;
	select * from students where height = (select max(height) from students);

	-- 列级子查询
	-- 查询学生的班级号能够对应的学生信息
	-- select * from students where cls_id in (select id from classes);