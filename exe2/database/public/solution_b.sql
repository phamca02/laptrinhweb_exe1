-- 1. Liệt kê các hóa đơn của khách hàng
SELECT users.id AS user_id, users.name AS user_name, orders.order_id
FROM users
JOIN orders ON users.id = orders.user_id;

-- 2. Liệt kê số lượng các hóa đơn của khách hàng
SELECT users.id AS user_id, users.name AS user_name, COUNT(orders.order_id) AS order_count
FROM users
LEFT JOIN orders ON users.id = orders.user_id
GROUP BY users.id;

-- 3. Liệt kê thông tin hóa đơn: mã đơn hàng, số sản phẩm
SELECT orders.order_id, COUNT(order_details.product_id) AS total_products
FROM orders
JOIN order_details ON orders.order_id = order_details.order_id
GROUP BY orders.order_id;

-- 4. Liệt kê thông tin mua hàng của người dùng
SELECT users.id AS user_id, users.name AS user_name, orders.order_id, GROUP_CONCAT(products.product_name) AS product_names
FROM users
JOIN orders ON users.id = orders.user_id
JOIN order_details ON orders.order_id = order_details.order_id
JOIN products ON order_details.product_id = products.product_id
GROUP BY orders.order_id, users.id
ORDER BY orders.order_id;

-- 5. Liệt kê 7 người dùng có số lượng đơn hàng nhiều nhất
SELECT users.id AS user_id, users.name AS user_name, COUNT(orders.order_id) AS order_count
FROM users
LEFT JOIN orders ON users.id = orders.user_id
GROUP BY users.id
ORDER BY order_count DESC
LIMIT 7;

-- 6. Liệt kê 7 người dùng mua sản phẩm có tên: Samsung hoặc Apple
SELECT users.id AS user_id, users.name AS user_name, orders.order_id, products.product_name
FROM users
JOIN orders ON users.id = orders.user_id
JOIN order_details ON orders.order_id = order_details.order_id
JOIN products ON order_details.product_id = products.product_id
WHERE products.product_name LIKE '%Samsung%' OR products.product_name LIKE '%Apple%'
LIMIT 7;

-- 7. Liệt kê danh sách mua hàng của user bao gồm giá tiền của mỗi đơn hàng
SELECT users.id AS user_id, users.name AS user_name, orders.order_id, SUM(products.product_price * order_details.quantity) AS total_price
FROM users
JOIN orders ON users.id = orders.user_id
JOIN order_details ON orders.order_id = order_details.order_id
JOIN products ON order_details.product_id = products.product_id
GROUP BY orders.order_id, users.id;

-- 8. Mỗi user chỉ chọn ra 1 đơn hàng có giá tiền lớn nhất
SELECT users.id AS user_id, users.name AS user_name, orders.order_id, SUM(products.product_price * order_details.quantity) AS total_price
FROM users
JOIN orders ON users.id = orders.user_id
JOIN order_details ON orders.order_id = order_details.order_id
JOIN products ON order_details.product_id = products.product_id
GROUP BY users.id, orders.order_id
HAVING total_price = (
    SELECT MAX(total_price) 
    FROM (
        SELECT SUM(products.product_price * order_details.quantity) AS total_price
        FROM orders
        JOIN order_details ON orders.order_id = order_details.order_id
        JOIN products ON order_details.product_id = products.product_id
        WHERE orders.user_id = users.id
        GROUP BY orders.order_id
    ) AS user_orders
);

-- 9. Mỗi user chỉ chọn ra 1 đơn hàng có giá tiền nhỏ nhất
SELECT users.id AS user_id, users.name AS user_name, orders.order_id, SUM(products.product_price * order_details.quantity) AS total_price
FROM users
JOIN orders ON users.id = orders.user_id
JOIN order_details ON orders.order_id = order_details.order_id
JOIN products ON order_details.product_id = products.product_id
GROUP BY users.id, orders.order_id
HAVING total_price = (
    SELECT MIN(total_price) 
    FROM (
        SELECT SUM(products.product_price * order_details.quantity) AS total_price
        FROM orders
        JOIN order_details ON orders.order_id = order_details.order_id
        JOIN products ON order_details.product_id = products.product_id
        WHERE orders.user_id = users.id
        GROUP BY orders.order_id
    ) AS user_orders
);

-- 10. Mỗi user chỉ chọn ra 1 đơn hàng có số sản phẩm là nhiều nhất
SELECT users.id AS user_id, users.name AS user_name, orders.order_id, SUM(order_details.quantity) AS total_products
FROM users
JOIN orders ON users.id = orders.user_id
JOIN order_details ON orders.order_id = order_details.order_id
GROUP BY users.id, orders.order_id
HAVING total_products = (
    SELECT MAX(total_products)
    FROM (
        SELECT order_id, SUM(quantity) AS total_products
        FROM order_details
        GROUP BY order_id
    ) AS order_totals
    WHERE order_id IN (
        SELECT orders.order_id
        FROM orders
        WHERE orders.user_id = users.id
    )
);
