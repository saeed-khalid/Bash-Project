# Create a more sophisticated sample log file


log_info() {
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    echo "$timestamp [ERROR]: $1" >> /log_analyzer.sh
}


log_warning() {
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    echo "$timestamp [failed]: $1" >> /log_analyzer.sh
}


log_error() {
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    echo "$timestamp [ERROR]: $1" >> /log_analyzer.sh
}


log_info "Application started successfully"
log_warning "Disk space is running low on /dev/sda"
log_error "Critical error: Database connection failed"
