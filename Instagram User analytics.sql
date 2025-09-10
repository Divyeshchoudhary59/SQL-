use ig_clone;

-- oldest users
select *
from users
order by created_at
limit 5;

-- The team wants to encourage inactive users to start posting by sending them promotional emails.
 -- never posted a single photo on Instagram-- 
select u.id, u.username 
  from users as u
  left join photos as p ON p.user_id = u.id
  where p.user_id is NULL; 

 
 -- The team has organized a contest where the user with the most likes on a single photo wins.
  -- the contest provide their details the team--
  
  with cte as (
  SELECT photo_id, COUNT(user_id) as total_likes
FROM likes
GROUP BY photo_id
ORDER BY total_likes DESC LIMIT 1)
select u.username, u.id, p.id as photo_id, cte.total_likes from cte
join photos as p on cte.photo_id = p.id
join users as u on p.user_id = u.id;  

 -- top five most commonly used hashtags  the platform--
 select * from tags;
 with cte as (select tag_id from photo_tags 
group by tag_id
order by count(tag_id) desc limit 5)
select t.tag_name from cte
join tags as t on cte.tag_id = t.id;

-- best din launch ads--
select dayname(created_at) as day_week, count(*) as total_users
from users
group by dayname(created_at)
order by total_users desc;

 -- Your Task: Calculate the average number of posts per user on Instagram. --
 -- Also, provide the total number of photos on Instagram divided by the total number of users--
 select avg(total_photos) from
 (select u.id, coalesce(count(p.id),0) as total_photos
 from users as u left join photos as p ON p.user_id = u.id
 group by u.id) as a;
 
 select avg(total_photos),max(a) from (select distinct u.id, coalesce(count(p.id) over(partition by u.id),0) as total_photos, 
 round(count(p.id) over() * 1.00/ count(u.id) over(),1) as a
 from users as u left join photos as p ON p.user_id = u.id) as b;
 




-- Your Task: Identify users (potential bots) who have liked every single photo on the site, 
-- as this is not typically possible for a normal user-- 

select username, count(*) as number_likes
from users as u join likes as l ON u.id = l.user_id
group by l.user_id
having number_likes = (select count(*) from photos)





 

  

 

