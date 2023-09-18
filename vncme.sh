vnc_show()
{
cat << 'EOF'
vncserver -list
vncserver -kill :1
vncserver :1 -geometry 1920x1200 -depth 32
EOF
}
