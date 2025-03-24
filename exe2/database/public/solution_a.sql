-- câu a
--Truy vấn người dùng
--1. Lấy ra danh sách người dùng theo thứ tự tên theo Alphabet (A->Z)
SELECT * FROM `users` ORDER BY name ASC;

--2. Lấy ra 07 người dùng theo thứ tự tên theo Alphabet (A->Z)
SELECT * FROM `users` ORDER BY name ASC LIMIT 7

--3. Lấy ra danh sách người dùng theo thứ tự tên theo Alphabet (A->Z), trong đó tên
--người dùng có chữ a
SELECT * FROM `users` WHERE name LIKE '%a%' ORDER BY name ASC;

--4. Lấy ra danh sách người dùng trong đó tên người dùng bắt đầu bằng chữ m
SELECT * FROM `users` WHERE name LIKE 'm%';

--5. Lấy ra danh sách người dùng trong đó tên người dùng kết thúc bằng chữ i
SELECT * FROM `users` WHERE name LIKE '%i';

--6. Lấy ra danh sách người dùng trong đó email người dùng là Gmail (ví dụ:
--example@gmail.com)
SELECT * FROM users WHERE email LIKE '%@gmail.com'

--7. Lấy ra danh sách người dùng trong đó email người dùng là Gmail (ví dụ:
--example@gmail.com), tên người dùng bắt đầu bằng chữ m
SELECT * FROM users WHERE email LIKE '%@gmail.com' AND name LIKE 'm%'


/*8. Lấy ra danh sách người dùng trong đó email người dùng là Gmail (ví dụ:
example@gmail.com), tên người dùng có chữ i và tên người dùng có chiều dài lớn
hơn 5*/
SELECT * FROM users WHERE email LIKE '%@gmail.com' AND name LIKE '%i%' AND LENGTH(name) > 5

--9. Lấy ra danh sách người dùng trong đó tên người dùng có chữ a, chiều dài từ 5 đến 9, email dùng dịch vụ Gmail, trong tên email có chữ I (trong tên, chứ không phải
--domain exampleitest@yahoo.com)
SELECT * FROM users 
WHERE name LIKE '%a%' AND LENGTH(name) BETWEEN 5 AND 9 
AND email LIKE '%@gmail.com' AND email LIKE '%i%';

/*
10. Lấy ra danh sách người dùng trong đó tên người dùng có chữ a, chiều dài từ 5
đến 9 hoặc tên người dùng có chữ i, chiều dài nhỏ hơn 9 hoặc email dùng dịch vụ
Gmail, trong tên email có chữ i */
SELECT * FROM users
WHERE (name LIKE '%a%' AND LENGTH(name) BETWEEN 5 AND 9) 
   OR (name LIKE '%i%' AND LENGTH(name) < 9) 
   OR (email LIKE '%@gmail.com' AND email LIKE '%i%');
