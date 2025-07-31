return new Proxy(Function('console.log({arguments})'), {
                get(target, prop, receiver) {
                    console.log(`get: ${prop}`);
                },
                apply(target, thisArg, argumentsList) {
                    console.log(`apply:`, {thisArg, argumentsList});
                    return target(argumentsList[0], argumentsList[1]) * 10;
                },
                construct(target, args) {
                    console.log(`construct ${args}`);
                    return new target(...args);
                },
                defineProperty(target, key, descriptor) {
                    console.log(`defineProperty: ${key}`);
                    return true;
                },
                deleteProperty(target, prop) {
                    console.log(`deleteProperty: ${prop}`);
                },
                getOwnPropertyDescriptor(target, prop) {
                    console.log(`getOwnPropertyDescriptor: ${prop}`);
                    // Expected output: "called: eyeCount"
                    return { configurable: true, enumerable: true, value: 5 };
                },
                getPrototypeOf(target) {
                    console.log(`getPrototypeOf: ${key}`);
                    return;
                },
                has(target, key) {
                    console.log(`has: ${key}`);
                },
                isExtensible(target) {
                    console.log(`isExtensible:`);
                },
                preventExtensions(target) {
                    console.log(`preventExtensions:`);
                },
                ownKeys(target) {
                    console.log(`ownKeys:`);
                },
                set(target, key, value) {
                    console.log(`set:`, key, value);
                },
                setPrototypeOf(monster, monsterProto) {
                    console.log(`setPrototypeOf:`, monsterProto);
                },
            });