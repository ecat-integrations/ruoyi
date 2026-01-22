var date = {
    currDate() {
        // 创建一个 Date 对象，它会自动获取当前时间
        const now = new Date();

        // 获取年、月、日、时、分、秒
        const year = now.getFullYear();
        const month = String(now.getMonth() + 1).padStart(2, '0');
        const day = String(now.getDate()).padStart(2, '0');
        const hours = String(now.getHours()).padStart(2, '0');
        const minutes = String(now.getMinutes()).padStart(2, '0');
        const seconds = String(now.getSeconds()).padStart(2, '0');

        // 组合成所需格式的时间字符串
        const currentTime = `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
        return currentTime; 
    }
}
export default date;