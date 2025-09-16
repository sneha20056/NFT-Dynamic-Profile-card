module MyModule::NFTProfileCards {
    use aptos_framework::signer;
    use std::string::{Self, String};
    use std::vector;
    
    /// Struct representing an NFT Dynamic Profile Card
    struct ProfileCard has store, key {
        name: String,           // User's display name
        bio: String,            // User's biography  
        avatar_url: String,     // URL to profile avatar image
        level: u64,             // Dynamic level that can increase
        achievements: vector<String>, // List of achievements earned
        last_updated: u64,      // Timestamp of last update
    }
    
    /// Function to create a new dynamic profile card NFT
    public fun create_profile_card(
        owner: &signer, 
        name: String, 
        bio: String, 
        avatar_url: String
    ) {
        let profile_card = ProfileCard {
            name,
            bio, 
            avatar_url,
            level: 1,
            achievements: vector::empty<String>(),
            last_updated: 0, // In a real implementation, use timestamp::now_seconds()
        };
        move_to(owner, profile_card);
    }
    
    /// Function to update the dynamic profile card with new achievements and level
    public fun update_profile_card(
        owner: &signer,
        new_achievement: String,
        level_increase: u64
    ) acquires ProfileCard {
        let card_addr = signer::address_of(owner);
        let profile_card = borrow_global_mut<ProfileCard>(card_addr);
        
        // Add new achievement to the list
        vector::push_back(&mut profile_card.achievements, new_achievement);
        
        // Increase level dynamically
        profile_card.level = profile_card.level + level_increase;
        
        // Update timestamp (simplified for this example)
        profile_card.last_updated = profile_card.last_updated + 1;
    }
}