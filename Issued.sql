SELECT 
    books.book_id,
    books.title,
    members.name,
    transactions.issue_date
FROM transactions
JOIN books ON transactions.book_id = books.book_id
JOIN members ON transactions.member_id = members.member_id
WHERE transactions.status = 'issued';
