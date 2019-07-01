
# Libjq with ruby bindings debugger

Using the [jq](https://jqplay.org/s/J_typLJjIK) command line tool:

```shell
jq 'scan("foo(.+)")' <<< '"foobar"'
```
outputs:
```
[
  "bar"
]
```

but using **libjq** with **ruby** returns empty string `[""]`.

### Run test using docker image

Build image using:
```shell
docker build -t libjq-test .
```

Run test using:
```shell
docker run -it libjq-test
```

Output (note the empty capture at 0017):
```
Loaded suite test
Started
F
===============================================================================
Failure: test_scan_with_grouping(TestSimple)
test.rb:12:in `test_scan_with_grouping'
      9:   end
     10:
     11:   def test_scan_with_grouping
  => 12:     assert_equal('["bar"]', @output)
     13:   end
     14:
     15: end
<"[\"bar\"]"> expected but was
<"[\"\"]">

diff:
? ["bar"]
===============================================================================

Finished in 0.0423762 seconds.
-------------------------------------------------------------------------------
1 tests, 1 assertions, 1 failures, 0 errors, 0 pendings, 0 omissions, 0 notifications
0% passed
-------------------------------------------------------------------------------
23.60 tests/s, 23.60 assertions/s
0000 TOP
0001 CALL_JQ scan:1 @lambda:2	"foobar" (1)
0000 CALL_JQ match:0^1 @lambda:0 @lambda:1	"foobar" (1)
0000 PUSHK_UNDER false	"foobar" (1)
0002 SUBEXP_BEGIN	"foobar" (1)
0003 CALL_JQ mode:1	"foobar" (2)
0000 LOADK "g"	"foobar" (2)
0002 RET	"g" (2)
0007 SUBEXP_END	"g" (2) | "foobar" (1)
0008 SUBEXP_BEGIN	"foobar" (1)
0009 CALL_JQ re:0	"foobar" (2)
0000 TAIL_CALL_JQ re:0^1	"foobar" (2)
0000 LOADK "foo(.+)"	"foobar" (2)
0002 RET	"foo(.+)" (2)
0013 SUBEXP_END	"foo(.+)" (2) | "foobar" (1)
0014 CALL_BUILTIN _match_impl	"foobar" (1) | "foo(.+)" (2) | "g" (2) | false
0017 EACH	[{"offset":0,"length":6,"string":"foobar" (1),"captures":[{"offset":0,"string":"" (1),"length":0,"name":null} (1)] (1)} (1)] (1)
0018 RET	{"offset":0,"length":6,"string":"foobar" (1),"captures":[{"offset":0,"string":"" (1),"length":0,"name":null} (1)] (1)} (1)
0008 DUP	{"offset":0,"length":6,"string":"foobar" (1),"captures":[{"offset":0,"string":"" (1),"length":0,"name":null} (1)] (1)} (1)
0009 SUBEXP_BEGIN	{"offset":0,"length":6,"string":"foobar" (1),"captures":[{"offset":0,"string":"" (1),"length":0,"name":null} (1)] (1)} (2)
0010 PUSHK_UNDER "captures"	{"offset":0,"length":6,"string":"foobar" (1),"captures":[{"offset":0,"string":"" (1),"length":0,"name":null} (1)] (1)} (3)
0012 INDEX	{"offset":0,"length":6,"string":"foobar" (1),"captures":[{"offset":0,"string":"" (1),"length":0,"name":null} (1)] (1)} (3) | "captures" (2)
0013 PUSHK_UNDER 0	[{"offset":0,"string":"" (1),"length":0,"name":null} (1)] (2)
0015 SUBEXP_BEGIN	[{"offset":0,"string":"" (1),"length":0,"name":null} (1)] (2)
0016 CALL_BUILTIN length	[{"offset":0,"string":"" (1),"length":0,"name":null} (1)] (3)
0019 SUBEXP_END	1 | [{"offset":0,"string":"" (1),"length":0,"name":null} (1)] (2)
0020 CALL_BUILTIN _greater	[{"offset":0,"string":"" (1),"length":0,"name":null} (1)] (2) | 1 | 0
0023 SUBEXP_END	true | {"offset":0,"length":6,"string":"foobar" (1),"captures":[{"offset":0,"string":"" (1),"length":0,"name":null} (1)] (1)} (2)
0024 POP	{"offset":0,"length":6,"string":"foobar" (1),"captures":[{"offset":0,"string":"" (1),"length":0,"name":null} (1)] (1)} (2)
0025 JUMP_F 0052	true
0027 POP	true
0028 DUP	{"offset":0,"length":6,"string":"foobar" (1),"captures":[{"offset":0,"string":"" (1),"length":0,"name":null} (1)] (1)} (1)
0029 LOADK []	{"offset":0,"length":6,"string":"foobar" (1),"captures":[{"offset":0,"string":"" (1),"length":0,"name":null} (1)] (1)} (2)
0031 STOREV $collect:0	[]
V0 = [] (2)
0034 FORK 0047
0036 PUSHK_UNDER "captures"	{"offset":0,"length":6,"string":"foobar" (1),"captures":[{"offset":0,"string":"" (1),"length":0,"name":null} (1)] (1)} (1)
0038 INDEX	{"offset":0,"length":6,"string":"foobar" (1),"captures":[{"offset":0,"string":"" (1),"length":0,"name":null} (1)] (1)} (2) | "captures" (2)
0039 EACH	[{"offset":0,"string":"" (1),"length":0,"name":null} (1)] (2)
0040 PUSHK_UNDER "string"	{"offset":0,"string":"" (1),"length":0,"name":null} (2)
0042 INDEX	{"offset":0,"string":"" (1),"length":0,"name":null} (2) | "string" (2)
0043 APPEND $collect:0	"" (2)
0046 BACKTRACK
0034 FORK 0047		<backtracking>
0047 LOADVN $collect:0	{"offset":0,"length":6,"string":"foobar" (1),"captures":[{"offset":0,"string":"" (2),"length":0,"name":null} (1)] (1)} (1)
V0 = [""] (1)
0050 JUMP 0056
0056 RET	["" (1)] (1)
0007 RET	["" (1)] (1)
```
