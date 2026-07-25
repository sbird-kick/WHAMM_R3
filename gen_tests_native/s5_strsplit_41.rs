fn main() {
    let data = "92,72,27,93,92,61,77";
    let parts: Vec<&str> = data.split(',').collect();
    let nums: Vec<i32> = parts.iter().map(|s| s.parse::<i32>().unwrap_or(0)).collect();
    let sum: i32 = nums.iter().sum();
    let joined2 = parts.join("_");
    println!("s5_strsplit_41 nums={:?}", nums);
    println!("sum={} joined={}", sum, joined2);
}
