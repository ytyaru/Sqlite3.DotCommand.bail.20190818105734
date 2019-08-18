SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd "$SCRIPT_DIR"

# SQLエラーで停止する
sqlite3 :memory: \
"create table T(C text not null);" \
"insert into T values('A');" \
"insert into T values(NULL);" \
"insert into T values('B');" \
"select * from T;"

# ONでも停止する
sqlite3 :memory: \
".bail ON" \
"create table T(C text not null);" \
"insert into T values('A');" \
"insert into T values(NULL);" \
"insert into T values('B');" \
"select * from T;"

# OFFでも停止する
sqlite3 :memory: \
".bail OFF" \
"create table T(C text not null);" \
"insert into T values('A');" \
"insert into T values(NULL);" \
"insert into T values('B');" \
"select * from T;"

# syntax error`でも
sqlite3 :memory: \
".bail OFF" \
"aaaaaaaaaa" \
"create table T(C text not null);" \
"insert into T values('A');" \
"insert into T values(NULL);" \
"insert into T values('B');" \
"select * from T;"

sqlite3 :memory: \
".bail ON" \
"aaaaaaaaaa" \
"create table T(C text not null);" \
"insert into T values('A');" \
"insert into T values(NULL);" \
"insert into T values('B');" \
"select * from T;"

