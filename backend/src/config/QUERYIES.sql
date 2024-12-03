CREATE OR REPLACE FUNCTION TABLE_EXISTS(table_name TEXT)
RETURNS BOOLEAN AS $$
BEGIN
    RETURN EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = table_name);
END;
$$ LANGUAGE plpgsql;

CREATE TABLE counts(
    id SERIAL PRIMARY KEY,
    count INT NOT NULL
)

IF NOT TABLE_EXISTS('roles') THEN
    CREATE TABLE roles (
        id SERIAL PRIMARY KEY,
        name VARCHAR(255) NOT NULL
    );
END IF;

IF NOT TABLE_EXISTS('users_roles') THEN
    CREATE TABLE users_roles (
        id SERIAL PRIMARY KEY,
        user_id INT NOT NULL,
        role_id INT NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
        FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE
    );
END IF;

IF NOT TABLE_EXISTS('categories') THEN
    CREATE TABLE categories (
        id SERIAL PRIMARY KEY,
        name VARCHAR(255) NOT NULL
    );
END IF;

IF NOT TABLE_EXISTS('posts_categories') THEN
    CREATE TABLE posts_categories (
        id SERIAL PRIMARY KEY,
        post_id INT NOT NULL,
        category_id INT NOT NULL,
        FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE,
        FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE CASCADE
    );
END IF;




IF NOT TABLE_EXISTS('users') THEN
    CREATE TABLE users (
        id SERIAL PRIMARY KEY,
        email VARCHAR(255) NOT NULL,
        password VARCHAR(255) NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
END IF;

IF NOT TABLE_EXISTS('posts') THEN
    CREATE TABLE posts (
        id SERIAL PRIMARY KEY,
        title VARCHAR(255) NOT NULL,
        content TEXT NOT NULL,
        user_id INT NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
    );
END IF;

IF NOT TABLE_EXISTS('comments') THEN
    CREATE TABLE comments (
        id SERIAL PRIMARY KEY,
        content TEXT NOT NULL,
        user_id INT NOT NULL,
        post_id INT NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
        FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE
    );
END IF;

IF NOT TABLE_EXISTS('likes') THEN
    CREATE TABLE likes (
        id SERIAL PRIMARY KEY,
        user_id INT NOT NULL,
        post_id INT NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
        FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE
    );
END IF;

IF NOT TABLE_EXISTS('follows') THEN
    CREATE TABLE follows (
        id SERIAL PRIMARY KEY,
        follower_id INT NOT NULL,
        following_id INT NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (follower_id) REFERENCES users(id) ON DELETE CASCADE,
        FOREIGN KEY (following_id) REFERENCES users(id) ON DELETE CASCADE
    );
END IF;

IF NOT TABLE_EXISTS('notifications') THEN
    CREATE TABLE notifications (
        id SERIAL PRIMARY KEY,
        user_id INT NOT NULL,
        content TEXT NOT NULL,
        read BOOLEAN DEFAULT FALSE,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
    );
END IF;

IF NOT TABLE_EXISTS('messages') THEN
    CREATE TABLE messages (
        id SERIAL PRIMARY KEY,
        sender_id INT NOT NULL,
        receiver_id INT NOT NULL,
        content TEXT NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (sender_id) REFERENCES users(id) ON DELETE CASCADE,
        FOREIGN KEY (receiver_id) REFERENCES users(id) ON DELETE CASCADE
    );
END IF;

IF NOT TABLE_EXISTS('chats') THEN
    CREATE TABLE chats (
        id SERIAL PRIMARY KEY,
        user_id INT NOT NULL,
        chat_with INT NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
        FOREIGN KEY (chat_with) REFERENCES users(id) ON DELETE CASCADE
    );
END IF;

IF NOT TABLE_EXISTS('chat_messages') THEN
    CREATE TABLE chat_messages (
        id SERIAL PRIMARY KEY,
        chat_id INT NOT NULL,
        sender_id INT NOT NULL,
        content TEXT NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (chat_id) REFERENCES chats(id) ON DELETE CASCADE,
        FOREIGN KEY (sender_id) REFERENCES users(id) ON DELETE CASCADE
    );
END IF;

IF NOT TABLE_EXISTS('replies') THEN
    CREATE TABLE replies (
        id SERIAL PRIMARY KEY,
        content TEXT NOT NULL,
        user_id INT NOT NULL,
        comment_id INT NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
        FOREIGN KEY (comment_id) REFERENCES comments(id) ON DELETE CASCADE
    );
END IF;

IF NOT TABLE_EXISTS('tags') THEN
    CREATE TABLE tags (
        id SERIAL PRIMARY KEY,
        name VARCHAR(255) NOT NULL
    );
END IF;

IF NOT TABLE_EXISTS('post_tags') THEN
    CREATE TABLE post_tags (
        id SERIAL PRIMARY KEY,
        post_id INT NOT NULL,
        tag_id INT NOT NULL,
        FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE,
        FOREIGN KEY (tag_id) REFERENCES tags(id) ON DELETE CASCADE
    );
END IF;

IF NOT TABLE_EXISTS('post_views') THEN
    CREATE TABLE post_views (
        id SERIAL PRIMARY KEY,
        post_id INT NOT NULL,
        user_id INT NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE,
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
    );
END IF;

IF NOT TABLE_EXISTS('post_reports') THEN
    CREATE TABLE post_reports (
        id SERIAL PRIMARY KEY,
        post_id INT NOT NULL,
        user_id INT NOT NULL,
        reason TEXT NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE,
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
    );
END IF;

