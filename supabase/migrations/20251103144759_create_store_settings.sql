/*
  # Create Store Settings Table

  1. New Tables
    - `store_settings`
      - `id` (uuid, primary key) - Unique identifier
      - `hero_image` (text) - URL of the main hero image
      - `gallery_images` (text array) - Array of gallery image URLs
      - `product_price` (numeric) - Product price
      - `freight_message` (text) - Freight/shipping message
      - `whatsapp_number` (text) - WhatsApp contact number
      - `created_at` (timestamptz) - Creation timestamp
      - `updated_at` (timestamptz) - Last update timestamp

  2. Security
    - Enable RLS on `store_settings` table
    - Add policy for public read access
    - Add policy for authenticated admin updates
*/

CREATE TABLE IF NOT EXISTS store_settings (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  hero_image text NOT NULL DEFAULT '/IMG-20251014-WA0001.jpg',
  gallery_images text[] DEFAULT ARRAY[]::text[],
  product_price numeric(10,2) NOT NULL DEFAULT 89.99,
  freight_message text DEFAULT 'Taxa de entrega: R$15,00 | Frete grátis para compras acima de R$150!',
  whatsapp_number text DEFAULT '5562946265700',
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

ALTER TABLE store_settings ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Anyone can read store settings"
  ON store_settings
  FOR SELECT
  USING (true);

CREATE POLICY "Authenticated users can update store settings"
  ON store_settings
  FOR UPDATE
  TO authenticated
  USING (true)
  WITH CHECK (true);

CREATE POLICY "Authenticated users can insert store settings"
  ON store_settings
  FOR INSERT
  TO authenticated
  WITH CHECK (true);

INSERT INTO store_settings (
  hero_image,
  gallery_images,
  product_price,
  freight_message,
  whatsapp_number
) VALUES (
  '/fita_cob_rgb_12v_rolo_5m_810led_m_16743_2_5a1f52ff76f92b7a82d8718fff78cc16.webp',
  ARRAY[
    '/90_fita_cob_rgb_12v_rolo_5m_810led_m_16743_3_31447220d4e10689c4ed7dc3d697fea2 copy.webp',
    '/61wkGgBFP5L copy.jpg',
    '/6272368800-smhyuiqtuj copy.webp',
    '/ledSetupGamer copy.jpg'
  ],
  89.99,
  'Taxa de entrega: R$15,00 | Frete grátis para compras acima de R$150!',
  '5562994626570'
)
ON CONFLICT (id) DO NOTHING;
