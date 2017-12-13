require 'pry'

$lines = {
  "N" => ["Times Square", "34th", "28th", "23rd", "Union Square", "8th"],
  "L" => ["8th", "6th", "Union Square", "3rd", "1st"],
  "6" => ["Grand Central", "33rd", "28th", "23rd", "Union Square", "Astor Place"]
}

def prompt(message)
  print message
  gets.chomp
end

def partA
  p $lines.keys
  start_line = prompt("Enter your train line: ").upcase
  puts $lines[start_line]
  start = prompt("Enter your starting station: ")
  start_index = $lines[start_line].index start
  change = $lines[start_line].index("Union Square")

  if change > start_index
    stations1 = ($lines[start_line][start_index..change]).drop(1)
  else
    stations1 = ($lines[start_line][change..start_index]).reverse.drop(1)
  end

  return {"line" => start_line,
          "stations" => stations1,
          "start" => start
          }
end

def partB
  p $lines.keys
  finish_line = prompt("Enter the line your destination is on: ").upcase
  change = $lines[finish_line].index("Union Square")
  puts $lines[finish_line]
  finish = prompt("Enter your destination: ")
  finish_index = $lines[finish_line].index finish
  if change > finish_index
    stations2 = ($lines[finish_line][finish_index..change]).reverse.drop(1)
  else
    stations2 = ($lines[finish_line][change..finish_index]).drop(1)
  end

  return {"line" => finish_line,
          "stations" => stations2,
          "finish" => finish}

end

def single_line(line, start, finish)
  start_i = $lines[line].index(start)
  finish_i = $lines[line].index(finish)

  if start_i > finish_i
    stations = ($lines[line][finish_i..start_i]).reverse.drop(1)
  else
    stations = ($lines[line][start_i..finish_i]).drop(1)
  end
  return {"stations" => stations}
end

def plan_trip

  journey1 = partA
  journey2 = partB

  unless journey1["line"] == journey2["line"]

    puts "You must travel through the following stops on the #{journey1["line"]} line: #{journey1["stations"].join(", ")}."
    puts "Change at Union Square"
    puts "Then travel #{journey2["stations"].length} stop(s) on the #{journey2["line"]}: #{journey2["stations"].join(", ")}"
    puts "#{journey1["stations"].length + journey2["stations"].length} stops in total"

  else
    unless journey1["start"] == journey2["finish"]
      single = single_line(journey1["line"], journey1["start"], journey2["finish"])
      puts "You must travel along the following stops: #{single["stations"].join(", ")}"
      puts "#{single["stations"].length} stops in total"
    else
      puts "You are already at your destination"
    end
  end
end

plan_trip
