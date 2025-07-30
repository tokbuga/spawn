import * as cp from "child_process"

cp.fork("client-a-to-x.js")
cp.fork("client-b-to-x.js")