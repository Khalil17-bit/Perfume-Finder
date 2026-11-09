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

  return (
    <div
      className={clsx(
        'group/bottle relative flex items-center justify-center select-none overflow-hidden mx-auto',
        // Fixed aspect ratio matching 800x1000 bottle canvas (4:5)
        isHero
          ? 'h-52 sm:h-60 w-[166px] sm:w-[192px]'
          : 'h-40 sm:h-48 w-[128px] sm:w-[153px]'
      )}
    >
      {/* Dynamic Ambient Juice Radiance Centered Behind Glass Body */}
      <div
        className={clsx(
          'pointer-events-none absolute top-[58%] -translate-y-1/2 left-1/2 -translate-x-1/2 h-20 w-20 rounded-full blur-2xl transition-all duration-300 opacity-60 group-hover/bottle:opacity-90',
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

      {/* Dynamic Fitted Glass Plaque Label Perfectly Centered on the Glass Body (Top 58%, Left 50%) */}
      <div
        className={clsx(
          'pointer-events-none absolute z-20 left-1/2 -translate-x-1/2 top-[58%] -translate-y-1/2 flex flex-col items-center justify-center text-center backdrop-blur-[2px] transition-transform duration-300 group-hover/bottle:scale-105',
          
          // Width bounded strictly to the inner 38%-44% of the container
          isHero ? 'w-[42%] px-1.5 py-1.5' : 'w-[40%] px-1 py-1',

          // Cylinder Label: soft rounded corners with vertical architectural proportion
          bottleType === 'cylinder' && [
            'rounded-md border border-white/20 bg-black/60 shadow-[inset_0_1px_3px_rgba(255,255,255,0.25),0_3px_8px_rgba(0,0,0,0.7)]',
            '[transform:translate(-50%,-50%)_perspective(500px)_rotateY(-1deg)]'
          ],
          // Square Label: crisp architectural plaque with gold/white micro-frame
          bottleType === 'square' && [
            'rounded-sm border border-white/25 bg-black/65 shadow-[inset_0_0_6px_rgba(0,0,0,0.85),0_4px_10px_rgba(0,0,0,0.7)]',
            '[transform:translate(-50%,-50%)_perspective(600px)]'
          ],
          // Curved Amphora Label: elliptical pill adhering cleanly to curved glass
          bottleType === 'curved' && [
            'rounded-full border border-amber-400/30 bg-black/65 shadow-[inset_0_1px_4px_rgba(255,215,0,0.2),0_4px_12px_rgba(0,0,0,0.75)]',
            '[transform:translate(-50%,-50%)_perspective(400px)_rotateX(3deg)]'
          ]
        )}
      >
        {brand && (
          <span
            className={clsx(
              'font-latin tracking-[0.14em] text-[#D4AF37] uppercase font-bold truncate max-w-full leading-none',
              isHero ? 'text-[7.5px] sm:text-[8.5px]' : 'text-[6.5px] sm:text-[7px]'
            )}
          >
            {brand}
          </span>
        )}
        <h4
          className={clsx(
            'font-latin font-black tracking-tight text-white leading-tight mt-0.5 line-clamp-2 max-w-full drop-shadow-[0_1px_3px_rgba(0,0,0,0.9)]',
            isHero ? 'text-[9.5px] sm:text-[11px]' : 'text-[8.5px] sm:text-[9.5px]'
          )}
        >
          {name}
        </h4>
        <span
          className={clsx(
            'mt-0.5 tracking-widest text-zinc-400 uppercase font-mono leading-none',
            isHero ? 'text-[6.5px]' : 'text-[5.5px]'
          )}
        >
          EAU DE PARFUM
        </span>
      </div>
    </div>
  );
}
