import random

def flip_coin():
    """Simulates flipping a coin and returns 'H' or 'T'."""
    return random.choice(['H', 'T'])

def merge_results(left_seq, right_seq, left_score, right_score):
    """Merges two sequences and updates Alice's and Bob's scores if necessary."""
    merged_seq = left_seq + right_seq
    alice_score = left_score[0] + right_score[0]
    bob_score = left_score[1] + right_score[1]

    # Check boundary between left and right halves for HH or HT
    if len(left_seq) > 0 and len(right_seq) > 0:
        if left_seq[-1] == 'H' and right_seq[0] == 'H':
            alice_score += 1
        elif left_seq[-1] == 'H' and right_seq[0] == 'T':
            bob_score += 1

    return merged_seq, alice_score, bob_score

def divide_and_conquer(sequence):
    """Recursive divide-and-conquer approach to compute scores."""
    if len(sequence) == 0:
        return '', 0, 0
    if len(sequence) == 1:
        return sequence, 0, 0
    
    mid = len(sequence) // 2
    left_seq, left_alice, left_bob = divide_and_conquer(sequence[:mid])
    right_seq, right_alice, right_bob = divide_and_conquer(sequence[mid:])
    
    # Merge results from left and right halves
    merged_seq, total_alice, total_bob = merge_results(left_seq, right_seq, (left_alice, left_bob), (right_alice, right_bob))

    return merged_seq, total_alice, total_bob

def calculate_probabilities(alice_score, bob_score, flip_count):
    """Calculates probabilities for Alice, Bob, and a tie."""
    if flip_count == 0:
        return 0.0, 0.0, 1.0  # Default tie if no flips
    
    total_games = alice_score + bob_score + (flip_count - (alice_score + bob_score))
    p_alice = alice_score / total_games if total_games > 0 else 0
    p_bob = bob_score / total_games if total_games > 0 else 0
    p_tie = (flip_count - (alice_score + bob_score)) / total_games if total_games > 0 else 1
    
    return p_alice, p_bob, p_tie

def play_game_with_flips():
    """Runs the game, allowing the user to specify the number of flips."""
    print("Welcome to the coin toss game!")
    while True:
        try:
            # User inputs the number of flips
            num_flips = int(input("Enter how many times you want to flip the coin (or type 0 to quit): "))
            if num_flips == 0:
                print("Game over!")
                break
            elif num_flips < 0:
                print("Please enter a positive number.")
                continue
            
            # Perform flips and calculate results
            sequence = ''.join([flip_coin() for _ in range(num_flips)])
            _, alice_score, bob_score = divide_and_conquer(sequence)
            
            # Calculate and display probabilities
            p_alice, p_bob, p_tie = calculate_probabilities(alice_score, bob_score, num_flips)
            print(f"\nAfter {num_flips} flips:")
            print(f"Current toss sequence: {sequence}")
            print(f"Alice's score: {alice_score}, Bob's score: {bob_score}")
            print(f"Probabilities:")
            print(f"P(Alice wins) = {p_alice:.2f}, P(Bob wins) = {p_bob:.2f}, P(Tie) = {p_tie:.2f}\n")
        
        except ValueError:
            print("Invalid input. Please enter a number.")

# Start the game
play_game_with_flips()
