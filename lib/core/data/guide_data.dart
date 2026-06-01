const guideData = {
  "tours": [
    {
      "id": "colosseum_main",
      "title": "The Grand Colosseum Tour",
      "subtitle": "Walk through 2,000 years of history",
      "description":
          "Experience the Colosseum from the arena floor to the upper tiers. This comprehensive tour covers the amphitheater's architecture, gladiatorial combat, and the underground hypogeum.",
      "coverImage": "assets/panoramas/title_image.jpg",
      "durationMinutes": 45,
      "points": [
        {
          "id": "entrance",
          "title": "The Grand Entrance",
          "subtitle": "Porta Triumphalis — Gate of Triumph",
          "description":
              "You stand before the northern entrance where gladiators once passed beneath the great arch. The travertine stone walls rise 48 meters around you. Imagine the roar of 50,000 spectators echoing through these very corridors.",
          "panoramaImage": "assets/panoramas/image_02.jpg",
          "narrationAudio": "assets/audio/01_entrance.mp3",
          "yaw": 180.0,
          "pitch": 10.0,
          "connections": ["arena_floor", "corridor"],
          "hotspots": [
            {
              "id": "travertine_walls",
              "title": "Travertine Facade",
              "description":
                  "The exterior is clad in travertine limestone, held together by 300 tons of iron clamps. Each block weighs up to 2.5 tons. The four-story facade follows the Greek architectural orders: Doric, Ionic, and Corinthian.",
              "yaw": -30.0,
              "pitch": 15.0,
              "icon": "architecture",
            },
            {
              "id": "vomitorium",
              "title": "The Vomitorium",
              "description":
                  "These arched passages, called vomitoria, allowed 50,000 spectators to enter and be seated in minutes. The name comes from the Latin 'to spew forth' — crowds poured through like water from a fountain.",
              "yaw": 45.0,
              "pitch": 5.0,
              "icon": "entrance",
            },
          ],
        },
        {
          "id": "arena_floor",
          "title": "The Arena Floor",
          "subtitle": "Where Gladiators Fought",
          "description":
              "The arena stretched 86 meters long and 54 meters wide. Beneath your feet lies the hypogeum — a maze of tunnels and cages where gladiators and wild animals waited before battle.",
          "panoramaImage": "assets/panoramas/image_03.png",
          "narrationAudio": "assets/audio/02_arena.mp3",
          "yaw": 0.0,
          "pitch": 0.0,
          "connections": ["entrance", "hypogeum", "upper_tier"],
          "hotspots": [
            {
              "id": "arena_surface",
              "title": "The Wooden Floor",
              "description":
                  "The original arena floor was made of wood, covered with sand (harena in Latin). The sand absorbed blood and could be replaced between shows. Below, 80 vertical shafts enabled dramatic entrances of scenery and animals.",
              "yaw": 0.0,
              "pitch": -20.0,
              "icon": "floor",
            },
            {
              "id": "seating_rows",
              "title": "The Cavea",
              "description":
                  "The seating area (cavea) was divided into four tiers. The podium — closest to the arena — was reserved for senators and the emperor. The highest seats were for common citizens and women.",
              "yaw": 90.0,
              "pitch": 30.0,
              "icon": "seating",
            },
            {
              "id": "velarium_poles",
              "title": "Velarium Supports",
              "description":
                  "Bronze brackets once held the velarium — a massive canvas awning operated by 1,000 sailors from the Roman naval fleet. It protected spectators from rain and sun during the long spectacles.",
              "yaw": -90.0,
              "pitch": 60.0,
              "icon": "roof",
            },
          ],
        },
        {
          "id": "hypogeum",
          "title": "The Hypogeum",
          "subtitle": "Underground Labyrinth",
          "description":
              "Two levels of underground passages stretch beneath the arena. Gladiators waited in cells. Lions paced in cages. Mechanical elevators raised beasts and scenery through trapdoors onto the arena floor.",
          "panoramaImage": "assets/panoramas/image_04.png",
          "narrationAudio": "assets/audio/03_hypogeum.mp3",
          "yaw": 45.0,
          "pitch": 0.0,
          "connections": ["arena_floor", "corridor"],
          "hotspots": [
            {
              "id": "elevator_shafts",
              "title": "Mechanical Elevators",
              "description":
                  "36 trapdoors in the arena floor connected to underground elevators powered by slaves turning capstans. Animals, scenery, and even gladiators could appear as if by magic in the center of the arena.",
              "yaw": 0.0,
              "pitch": -15.0,
              "icon": "machinery",
            },
            {
              "id": "tunnel_system",
              "title": "The Tunnel Network",
              "description":
                  "A network of tunnels connected to the Ludus Magnus — the gladiator training school nearby. Gladiators could march directly from training to the arena without ever seeing daylight or the crowds above.",
              "yaw": 135.0,
              "pitch": 5.0,
              "icon": "tunnel",
            },
          ],
        },
        {
          "id": "upper_tier",
          "title": "The Upper Tier",
          "subtitle": "Seats of the Citizens",
          "description":
              "From the highest point of the Colosseum, Rome stretches before you in all directions. The Temple of Venus, the Forum, and the Palatine Hill are all visible from this vantage point.",
          "panoramaImage": "assets/panoramas/image_05.jpg",
          "narrationAudio": "assets/audio/04_upper_tier.mp3",
          "yaw": -60.0,
          "pitch": 20.0,
          "connections": ["arena_floor", "exit_view"],
          "hotspots": [
            {
              "id": "forum_view",
              "title": "View of the Roman Forum",
              "description":
                  "To the southeast, the ruins of the Roman Forum stretch along the Sacred Way. Temples, basilicas, and triumphal arches mark the political heart of the ancient empire.",
              "yaw": 120.0,
              "pitch": 25.0,
              "icon": "viewpoint",
            },
            {
              "id": "arch_constantine",
              "title": "Arch of Constantine",
              "description":
                  "The triumphal arch visible just west of the Colosseum was erected in 315 AD to commemorate Constantine's victory. Much of its decoration was scavenged from earlier monuments — an ancient form of recycling.",
              "yaw": -120.0,
              "pitch": 20.0,
              "icon": "monument",
            },
          ],
        },
        {
          "id": "corridor",
          "title": "The Ambulacrum",
          "subtitle": "Ancient Corridors",
          "description":
              "These barrel-vaulted corridors ringed each level of the Colosseum. During spectacles, vendors sold bread and wine. The walls still bear graffiti scratched by Roman spectators waiting for the games to begin.",
          "panoramaImage": "assets/panoramas/image_06.png",
          "narrationAudio": "assets/audio/05_corridor.mp3",
          "yaw": 90.0,
          "pitch": 5.0,
          "connections": ["entrance", "hypogeum"],
          "hotspots": [
            {
              "id": "ancient_graffiti",
              "title": "Roman Graffiti",
              "description":
                  "Scratched into the plaster walls are names, insults, and bets. One reads: 'Celadus the Thracian makes all the girls sigh.' Another: 'Antiochus hung out here with his girlfriend Cypere.'",
              "yaw": -45.0,
              "pitch": 10.0,
              "icon": "writing",
            },
            {
              "id": "barrel_vault",
              "title": "Barrel Vault Ceiling",
              "description":
                  "The semi-cylindrical vault is a hallmark of Roman engineering. Concrete — invented by the Romans — made these vast spans possible without internal supports, creating open circulation spaces.",
              "yaw": 0.0,
              "pitch": 45.0,
              "icon": "architecture",
            },
          ],
        },
        {
          "id": "exit_view",
          "title": "The Colosseum at Sunset",
          "subtitle": "A Timeless Silhouette",
          "description":
              "The golden light of the setting sun transforms the Colosseum's ruins into a timeless silhouette. For nearly two millennia, this monument has stood as a testament to Roman engineering ambition and the enduring fascination of the arena.",
          "panoramaImage": "assets/panoramas/image_07.jpg",
          "narrationAudio": "assets/audio/06_sunset.mp3",
          "yaw": 0.0,
          "pitch": 15.0,
          "connections": ["upper_tier"],
          "hotspots": [
            {
              "id": "night_games",
              "title": "Night Spectacles",
              "description":
                  "On special occasions, the entire Colosseum was illuminated by torches and lamps for nocturnal games. Transparent sheets of stone (lapis specularis) were used to project images — an early form of special effects.",
              "yaw": 60.0,
              "pitch": 30.0,
              "icon": "entertainment",
            },
          ],
        },
      ],
    },
    {
      "id": "colosseum_underground",
      "title": "Secrets Below",
      "subtitle": "The Hidden Underground",
      "description":
          "Descend into the recently restored underground levels of the Colosseum. Explore the hypogeum, animal pens, and mechanical systems that made the spectacles possible.",
      "coverImage": "assets/ui/tour_cover_underground.jpg",
      "durationMinutes": 30,
      "points": [],
    },
    {
      "id": "colosseum_night",
      "title": "Moonlit Arena",
      "subtitle": "The Colosseum by Night",
      "description":
          "Experience the Colosseum under moonlight as the ancient Romans did during special nocturnal games. Torches, shadows, and stone create an unforgettable atmosphere.",
      "coverImage": "assets/ui/tour_cover_night.jpg",
      "durationMinutes": 25,
      "points": [],
    },
  ],
};


