
1. 有没有可能同一个时间段执行多次 call pr_match_get_cfg_list()存储过程，比如：
	call pr_match_get_cfg_list(10);
	call pr_match_get_cfg_list(20);
	call pr_match_get_cfg_list(30);
	
	
	如果有，则建议不需要对查询到的数据加锁，目前的环境是默认加锁
	因为可能会造成死锁，导致存储过程执行失败; 
		-- 做个实验验证下。
		
		
2. 如果没有第1点，则不考虑下面的场景

3. 避免死锁的优化

	在执行nsert into ... select ... 语句前添加一行语句：
	目的是为了降低事务隔离级别为RC，不需要对查询到的数据加锁;
	
4. 有没有这样的场景
	有没有可能同一个时间段执行多次 call pr_match_get_cfg_list()存储过程并且传入的俱乐部ID是同一个，比如：

	call pr_match_get_cfg_list(10);
	call pr_match_get_cfg_list(10);
	call pr_match_get_cfg_list(10);
	
	
	有的话就需要串行执行; 
	
	
	
	
游客创建的存储过程：
1. 建立一个新的数据表，表中只有一行记录
	
2. 封测上这个表的的 status 字段为0，2RM上为1

	if status=1 THEN 
		2RM上的
		
	else
		封测和24上的逻辑
	end if ;

不用每次都从封测和2RM上下载下来进行修改了; 


