import RedisServer from 'redis-server';
const server = new RedisServer(6379);
const serverError = await server.open();
if (serverError !== null) {
    process.exit(console.log("redisservererror", serverError));
};
