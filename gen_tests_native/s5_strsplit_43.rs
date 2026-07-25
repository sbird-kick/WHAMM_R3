fn main() {
    let data = "77|36|99|41|74";
    let parts: Vec<&str> = data.split('|').collect();
    let nums: Vec<i32> = parts.iter().map(|s| s.parse::<i32>().unwrap_or(0)).collect();
    let sum: i32 = nums.iter().sum();
    let joined2 = parts.join("_");
    println!("s5_strsplit_43 nums={:?}", nums);
    println!("sum={} joined={}", sum, joined2);
}
