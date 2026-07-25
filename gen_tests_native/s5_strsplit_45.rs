fn main() {
    let data = "65|27|87|22|53|69|77";
    let parts: Vec<&str> = data.split('|').collect();
    let nums: Vec<i32> = parts.iter().map(|s| s.parse::<i32>().unwrap_or(0)).collect();
    let sum: i32 = nums.iter().sum();
    let joined2 = parts.join("_");
    println!("s5_strsplit_45 nums={:?}", nums);
    println!("sum={} joined={}", sum, joined2);
}
