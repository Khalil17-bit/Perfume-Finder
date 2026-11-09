'use client';

import { useMemo } from 'react';
import clsx from 'clsx';

interface PerfumeBottleDisplayProps {
  id: string;
  name: string;
  brand?: string | null;
  isHero?: boolean;
}

export function PerfumeBottleDisplay({ id, name, brand, isHero = false }: PerfumeBottleDisplayProps) {
  // Deterministically select bottle shape based on perfume ID hash
  const bottleType = useMemo(() => {
    let hash = 0;
    for (let i = 0; i < id.length; i++) {
      hash = (hash << 5) - hash + id.charCodeAt(i);
      hash |= 0;
    }
    const types = ['cylinder', 'square', 'curved'] as const;
    const selected = types[Math.abs(hash) % types.length];
    return selected;
  }, [id]);

  const bottleSrc = `/assets/bottles/bottle_${bottleType}.png`;

  // Clean brand name and perfume title
  const cleanBrand = brand?.trim() || null;
  const cleanName = name?.trim() || '';

  return (
    <div
      className={clsx(
        'group/bottle relative flex items-center justify-center select-none overflow-hidden mx-auto',
        // Fixed aspect ratio matching 800x1000 bottle canvas (4:5)
        isHero
          ? 'h-52 sm:h-60 w-[172px] sm:w-[200px]'
          : 'h-40 sm:h-48 w-[132px] sm:w-[158px]'
      )}
    >
      {/* Dynamic Ambient Juice Radiance Centered Behind Glass Body */}
      <div
        className={clsx(
          'pointer-events-none absolute top-[58%] -translate-y-1/2 left-1/2 -translate-x-1/2 h-24 w-24 rounded-full blur-2xl transition-all duration-300 opacity-60 group-hover/bottle:opacity-90',
          bottleType === 'curved' && 'bg-amber-500/25',
          bottleType === 'square' && 'bg-orange-500/20',
          bottleType === 'cylinder' && 'bg-amber-400/20'
        )}
        aria-hidden="true"
      />

      {/* Main Transparent Blank Bottle (Centered 100% of canvas) */}
      <img
        src={bottleSrc}
        alt={name}
        loading="lazy"
        draggable={false}
        className="relative z-10 h-full w-full object-contain select-none pointer-events-none drop-shadow-[0_12px_24px_rgba(0,0,0,0.85)] transition-transform duration-300 group-hover/bottle:scale-105 will-change-transform"
      />

      {/* Dynamic Fitted Glass Plaque Label Perfectly Centered on the Glass Body */}
      <div
        className={clsx(
          'pointer-events-none absolute z-20 left-1/2 -translate-x-1/2 top-[58%] -translate-y-1/2 flex flex-col items-center justify-center text-center backdrop-blur-[3px] transition-transform duration-300 group-hover/bottle:scale-105',
          
          // Width bounded to bottle inner torso width with generous internal padding so text never touches the border
          isHero
            ? 'w-[56%] max-w-[118px] sm:max-w-[130px] px-2.5 py-2 sm:px-3 sm:py-2.5'
            : 'w-[54%] max-w-[96px] sm:max-w-[108px] px-2 py-1.5 sm:px-2.5 sm:py-2',

          // Cylinder Label: soft rounded corners with vertical architectural proportion
          bottleType === 'cylinder' && [
            'rounded-xl border border-white/20 bg-black/75 shadow-[inset_0_1px_3px_rgba(255,255,255,0.25),0_4px_12px_rgba(0,0,0,0.8)]',
            '[transform:translate(-50%,-50%)_perspective(500px)_rotateY(-1deg)]'
          ],
          // Square Label: crisp architectural plaque with gold/white micro-frame
          bottleType === 'square' && [
            'rounded-lg border border-white/25 bg-black/75 shadow-[inset_0_0_6px_rgba(0,0,0,0.85),0_4px_12px_rgba(0,0,0,0.8)]',
            '[transform:translate(-50%,-50%)_perspective(600px)]'
          ],
          // Curved Amphora Label: smooth rounded squircle plaque adhering cleanly to curved glass
          bottleType === 'curved' && [
            'rounded-2xl border border-amber-400/35 bg-black/75 shadow-[inset_0_1px_4px_rgba(255,215,0,0.25),0_4px_14px_rgba(0,0,0,0.85)] ring-1 ring-amber-500/20',
            '[transform:translate(-50%,-50%)_perspective(400px)_rotateX(2deg)]'
          ]
        )}
      >
        {cleanBrand && (
          <span
            className={clsx(
              'font-latin tracking-[0.14em] text-[#D4AF37] uppercase font-bold max-w-full leading-tight text-center truncate',
              isHero ? 'text-[7px] sm:text-[8px] mb-0.5' : 'text-[6px] sm:text-[7px] mb-0.5'
            )}
          >
            {cleanBrand}
          </span>
        )}
        <h4
          className={clsx(
            'font-latin font-extrabold tracking-tight text-white leading-[1.15] text-center w-full break-words hyphens-auto drop-shadow-[0_1px_3px_rgba(0,0,0,0.95)]',
            isHero ? 'text-[8.5px] sm:text-[10px] my-0.5' : 'text-[7.5px] sm:text-[8.5px] my-0.5'
          )}
        >
          {cleanName}
        </h4>
        <span
          className={clsx(
            'tracking-wider text-zinc-400 uppercase font-mono leading-none text-center',
            isHero ? 'text-[5.5px] sm:text-[6.5px] mt-0.5' : 'text-[5px] sm:text-[5.5px] mt-0.5'
          )}
        >
          EAU DE PARFUM
        </span>
      </div>
    </div>
  );
}
