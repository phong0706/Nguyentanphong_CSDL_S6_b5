drop table if exists users;

create table users (
    user_id int primary key auto_increment,
    user_name varchar(255),
    total_orders int default null
);

insert into users (user_name, total_orders) values
('nguyen tan phong', 600),
('tran thi hoai', 350),
('le van tam', 50),
('pham minh duc', null),
('hoang thi lan', 100),
('dang van quy', 501);

select 
    user_name as Tên_Khách_Hàng, 
    case 
        when coalesce(total_orders, 0) > 500 then 'Kim Cương'
        when coalesce(total_orders, 0) >= 100 then 'Vàng'
        else 'Bạc'
    end as Xep_Hang
from users;