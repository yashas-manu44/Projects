-- CWL Dallas DATA -- first tournament for 2018 CDL 

select * from CWL_Dallas_data;

with player_table as (
	select player, team, kills, mode, map, kill_death, plus_minus
	from CWL_Dallas_data
	order by player ASC)

select player, round(avg(kills), 2) as avg_kills, round(avg(kill_death) ,2) as avg_kd
from player_table
group by player
having avg(kill_death) > 1.4
order by avg_kd DESC;

-- Hardpoint top performances 
select player, round(avg(kills), 2) as AverageKills, round(avg(kill_death), 2) as AverageKD
from CWL_Dallas_data
where mode = 'Hardpoint'
Group by player
order by AverageKD DESC
;

-- Search and destroy top performances 
select player, round(avg(kills), 2) as AverageKills, round(avg(kill_death), 2) as AverageKD
from CWL_Dallas_data
where mode = 'Search & Destroy'
Group by player
order by AverageKD DESC
limit 10;

-- Capture the Flag top performances 
select player, round(avg(kills), 2) as AverageKills, round(avg(kill_death), 2) as AverageKD
from CWL_Dallas_data
where mode = 'Capture The Flag'
Group by player
order by AverageKD DESC
limit 10;


-- Most wins across all maps and gamemodes 
select team, Count(result) as Number_of_wins
from CWL_Dallas_data
where result = 'W'
Group by team
order by Number_of_wins DESC;

-- Best team performance 
select team, round(avg(kills), 2) as TotalKills, round(avg(kill_death),2) as Average_Team_KD
from CWL_Dallas_data
group by team
order by Average_Team_KD DESC, TotalKills;


-------------------
/* Now Look at the same for the CDL ProLeague Stage1 which is the first major tournament */

select * from CWL_ProLeague_stage1;

with player_table as (
	select player, team, kills, mode, map, kill_death, plus_minus
	from CWL_ProLeague_stage1
	order by player ASC)

select player, round(avg(kills), 2) as avg_kills, round(avg(kill_death) ,2) as avg_kd
from player_table
group by player
having avg(kill_death) > 1.2
order by avg_kd DESC;


-- Hardpoint top performances 

select player, round(avg(kills), 2) as AverageKills, round(avg(kill_death), 2) as AverageKD
from CWL_ProLeague_stage1
where mode = 'Hardpoint'
Group by player
order by AverageKD DESC
;

-- Search and destroy top performances 

select player, round(avg(kills), 2) as AverageKills, round(avg(kill_death), 2) as AverageKD
from CWL_ProLeague_stage1
where mode = 'Search & Destroy'
Group by player
order by AverageKD DESC
limit 10;

-- Capture the Flag top performances 
select player, round(avg(kills), 2) as AverageKills, round(avg(kill_death), 2) as AverageKD
from CWL_ProLeague_stage1
where mode = 'Capture The Flag'
Group by player
order by AverageKD DESC
limit 10;


-- Most wins across all maps and gamemodes 
select team, Count(result) as Number_of_wins
from CWL_ProLeague_stage1
where result = 'W'
Group by team
order by Number_of_wins DESC;

-- Best team performance

select team, round(avg(kills), 2) as TotalKills, round(avg(kill_death),2) as Average_Team_KD
from CWL_ProLeague_stage1
group by team
order by Average_Team_KD DESC, TotalKills;


----------- Now lets look at the same for Major 2 ---

select * from CWL_ProLeague_stage2;

with player_table as (
	select player, team, kills, mode, map, kill_death, plus_minus
	from CWL_ProLeague_stage2
	order by player ASC)

select player, round(avg(kills), 2) as avg_kills, round(avg(kill_death) ,2) as avg_kd
from player_table
group by player
having avg(kill_death) > 1.2
order by avg_kd DESC;


-- Hardpoint top performances 

select player, round(avg(kills), 2) as AverageKills, round(avg(kill_death), 2) as AverageKD
from CWL_ProLeague_stage2
where mode = 'Hardpoint'
Group by player
order by AverageKD DESC
;

-- Search and destroy top performances 

select player, round(avg(kills), 2) as AverageKills, round(avg(kill_death), 2) as AverageKD
from CWL_ProLeague_stage2
where mode = 'Search & Destroy'
Group by player
order by AverageKD DESC
limit 10;

-- Capture the Flag top performances 
select player, round(avg(kills), 2) as AverageKills, round(avg(kill_death), 2) as AverageKD
from CWL_ProLeague_stage2
where mode = 'Capture The Flag'
Group by player
order by AverageKD DESC
limit 10;


-- Most wins across all maps and gamemodes 
select team, Count(result) as Number_of_wins
from CWL_ProLeague_stage2
where result = 'W'
Group by team
order by Number_of_wins DESC;

-- Best team performance

select team, round(avg(kills), 2) as TotalKills, round(avg(kill_death),2) as Average_Team_KD
from CWL_ProLeague_stage2
group by team
order by Average_Team_KD DESC, TotalKills;


------------- NOW lets look at champs ----------------
/* Champs is the final tournament of the season and the biggest prize in the game, both in terms 
of money to be won and its importance */

select * from CWL_Champs;


-- Best K/D in champs 
with player_table as (
	select player, team, kills, mode, map, kill_death, plus_minus
	from CWL_Champs
	order by player ASC)

select player, round(avg(kills), 2) as avg_kills, round(avg(kill_death) ,2) as avg_kd
from player_table
group by player
having avg(kill_death) > 1.2
order by avg_kd DESC;


-- Hardpoint top performances 

select player, round(avg(kills), 2) as AverageKills, round(avg(kill_death), 2) as AverageKD
from CWL_Champs
where mode = 'Hardpoint'
Group by player
order by AverageKD DESC
;

-- Search and destroy top performances 

select player, round(avg(kills), 2) as AverageKills, round(avg(kill_death), 2) as AverageKD
from CWL_Champs
where mode = 'Search & Destroy'
Group by player
order by AverageKD DESC
limit 10;

-- Capture the Flag top performances 
select player, round(avg(kills), 2) as AverageKills, round(avg(kill_death), 2) as AverageKD
from CWL_Champs
where mode = 'Capture The Flag'
Group by player
order by AverageKD DESC
limit 10;


-- Most wins across all maps and gamemodes 
select team, Count(result) as Number_of_wins
from CWL_Champs
where result = 'W'
Group by team
order by Number_of_wins DESC;

-- Best team performance

select team, round(avg(kills), 2) as TotalKills, round(avg(kill_death),2) as Average_Team_KD
from CWL_Champs
group by team
order by Average_Team_KD DESC, TotalKills;






