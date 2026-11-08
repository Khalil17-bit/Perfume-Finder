import imageCompression from 'browser-image-compression';
import { createClient } from './supabase/client';

export interface CompressionResult {
  file: File;
  originalSizeKb: number;
  compressedSizeKb: number;
  dimensions: { width: number; height: number };
}

/**
 * Client-side WebP image compressor.
 * Enforces:
 * - Format: image/webp
 * - Max dimensions: 800 x 800 px
 * - Max size: < 150 KB (0.15 MB)
 */
export async function compressToWebP(imageFile: File): Promise<CompressionResult> {
  const originalSizeKb = Math.round(imageFile.size / 1024);

  const options = {
    maxSizeMB: 0.15, // Under 150 KB
    maxWidthOrHeight: 800, // Max 800px
    useWebWorker: true,
    fileType: 'image/webp',
  };

  const compressedBlob = await imageCompression(imageFile, options);

  // Convert blob to File with .webp extension
  const baseName = imageFile.name.replace(/\.[^/.]+$/, '');
  const webpFile = new File([compressedBlob], `${baseName}.webp`, {
    type: 'image/webp',
  });

  const compressedSizeKb = Math.round(webpFile.size / 1024);

  // Read dimensions
  const dimensions = await new Promise<{ width: number; height: number }>((resolve) => {
    const img = new Image();
    img.src = URL.createObjectURL(webpFile);
    img.onload = () => {
      resolve({ width: img.naturalWidth, height: img.naturalHeight });
    };
    img.onerror = () => {
      resolve({ width: 0, height: 0 });
    };
  });

  return {
    file: webpFile,
    originalSizeKb,
    compressedSizeKb,
    dimensions,
  };
}

/**
 * Uploads a compressed image to Supabase Storage and returns its public URL.
 */
export async function uploadAssetImage(
  file: File,
  folder: 'answers' | 'logo',
  bucket: string = 'perfume-finder-assets'
): Promise<string> {
  const compression = await compressToWebP(file);
  const supabase = createClient();

  const timestamp = Date.now();
  const cleanName = compression.file.name.replace(/[^a-zA-Z0-9.-]/g, '_');
  const filePath = `${folder}/${timestamp}_${cleanName}`;

  const { error: uploadError } = await supabase.storage
    .from(bucket)
    .upload(filePath, compression.file, {
      contentType: 'image/webp',
      upsert: true,
    });

  if (uploadError) {
    throw new Error(`Storage upload failed: ${uploadError.message}`);
  }

  const { data } = supabase.storage.from(bucket).getPublicUrl(filePath);
  return data.publicUrl;
}
