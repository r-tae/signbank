# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Signbank.Repo.insert!(%Signbank.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
Signbank.Repo.insert!(%Signbank.Dictionary.Sign{
  type: :citation,
  id_gloss: "house1a",
  id_gloss_annotation: "HOUSE",
  keywords: ["house", "home"],
  legacy_id: 1670,
  published: true,
  proposed_new_sign: false,
  morphology: %Signbank.Dictionary.Morphology{},
  phonology: %Signbank.Dictionary.Phonology{},
  variants: [
    %Signbank.Dictionary.Sign{
      type: :variant,
      id_gloss: "house1b",
      id_gloss_annotation: "HOUSE",
      keywords: ["home", "building"],
      legacy_id: 1675,
      published: true,
      proposed_new_sign: false,
      morphology: %Signbank.Dictionary.Morphology{},
      phonology: %Signbank.Dictionary.Phonology{},
      asl_gloss: "BUILDING",
      bsl_gloss: nil,
      iconicity: :translucent,
      is_asl_loan: false,
      is_bsl_loan: true,
      legacy_sign_number: 1670,
      signed_english_gloss: nil,
      is_signed_english_only: false
    }
  ],
  asl_gloss: "HOME",
  bsl_gloss: "HOUSE",
  iconicity: :transparent,
  is_asl_loan: false,
  is_bsl_loan: true,
  legacy_sign_number: 1670,
  signed_english_gloss: nil,
  is_signed_english_only: false,
  definitions: [
    %Signbank.Dictionary.Definition{
      text: "Hello world",
      pos: 0,
      role: :general,
      language: "en",
      published: true
    },
    %Signbank.Dictionary.Definition{
      text: "This is the second noun definition",
      pos: 1,
      role: :noun,
      language: "en",
      published: true
    },
    %Signbank.Dictionary.Definition{
      text: "This is the first noun definition",
      pos: 0,
      role: :noun,
      language: "en",
      published: true
    },
    %Signbank.Dictionary.Definition{
      text: "This is the only verb definition",
      pos: 0,
      role: :verb,
      language: "en",
      published: true
    }
  ]
})
