#!/bin/bash

bash_while() {
cat << 'EOF'
while read line; do echo $line; grep trace_call $line; done < files
EOF
}
