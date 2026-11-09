'use client';

import React, { useRef, useState } from 'react';
import { Check, Plus } from 'lucide-react';
import clsx from 'clsx';

interface ParallaxAnswerCardProps {
  id: string;
  title: string;
  subtitle?: string;
  imageUrl?: string | null;
  index: number;
  isSelected: boolean;
  onSelect: (id: string) => void;
  isKiosk?: boolean;
}

export function ParallaxAnswerCard({
  id,
  title,
  subtitle,
  imageUrl,
  index,
  isSelected,
  onSelect,
  isKiosk = false,
}: ParallaxAnswerCardProps) {
  const cardRef = useRef<HTMLButtonElement>(null);
  const [tilt, setTilt] = useState({ x: 0, y: 0, active: false });

  const handlePointerMove = (e: React.PointerEvent<HTMLButtonElement>) => {
    const el = cardRef.current;
    if (!el) return;
    const rect = el.getBoundingClientRect();
    const nx = ((e.clientX - rect.left) / rect.width - 0.5) * 2; // -1 to 1
    const ny = ((e.clientY - rect.top) / rect.height - 0.5) * 2; // -1 to 1
    setTilt({ x: nx, y: ny, active: true });
  };

  const handlePointerLeave = () => {
    setTilt({ x: 0, y: 0, active: false });
  };

  // GPU-only 3D transforms for card and floating object
  // Constrained micro-parallax to prevent border leakage or outlines breaking the card
  const cardTransform = tilt.active
    ? `perspective(900px) rotateX(${(-tilt.y * 3.0).toFixed(2)}deg) rotateY(${(tilt.x * 3.0).toFixed(2)}deg) translateZ(0)`
    : 'perspective(900px) rotateX(0deg) rotateY(0deg) translateZ(0)';

  const objectTransform = tilt.active
    ? `translate3d(${(tilt.x * 6).toFixed(1)}px, ${(tilt.y * 4 - 3).toFixed(1)}px, 10px) scale(1.03)`
    : isSelected
    ? 'translate3d(0px, -3px, 8px) scale(1.02)'
    : 'translate3d(0px, 0px, 0px) scale(1)';

  return (
    <button
      ref={cardRef}
      type="button"
      onClick={() => onSelect(id)}
      onPointerMove={handlePointerMove}
      onPointerLeave={handlePointerLeave}
      style={{
        transform: cardTransform,
        transformStyle: 'preserve-3d',
      }}
      className={clsx(
        'group relative flex flex-col justify-between overflow-hidden rounded-2xl border text-start transition-colors duration-200 cursor-pointer select-none animate-gpu',
        isKiosk ? 'min-h-[260px] p-5' : 'min-h-[175px] sm:min-h-[220px] p-3.5 sm:p-5',
        isSelected
          ? 'border-[#FF5500] bg-[#16161A] ring-1 ring-[#FF5500]/50'
          : 'border-[#242429] bg-[#141417] hover:border-[#3A3A42] hover:bg-[#17171B]'
      )}
    >
      {/* Top Index Micro-Pill */}
      <div className="relative z-10 flex w-full items-center justify-between">
        <span
          className={clsx(
            'font-mono text-[9px] sm:text-[10px] font-semibold tracking-widest uppercase transition-colors',
            isSelected ? 'text-[#FF5500]' : 'text-zinc-600 group-hover:text-zinc-400'
          )}
        >
          0{index + 1}
        </span>
      </div>

      {/* Center Stage: Isolated Transparent PNG Object with 3D Parallax */}
      <div className="relative z-10 my-auto flex h-20 sm:h-28 lg:h-36 w-full items-center justify-center">
        {imageUrl ? (
          <div
            style={{ transform: objectTransform }}
            className="relative flex h-full w-full items-center justify-center transition-transform duration-200 ease-out will-change-transform"
          >
            <img
              src={imageUrl}
              alt={title}
              loading="eager"
              draggable={false}
              className={clsx(
                'h-18 w-18 sm:h-26 sm:w-26 lg:h-32 lg:w-32 object-contain select-none pointer-events-none transition-opacity duration-200',
                'brightness-[0.98] contrast-[1.06] drop-shadow-[0_14px_16px_rgba(0,0,0,0.85)]',
                (tilt.active || isSelected) && 'brightness-[1.05]'
              )}
            />
          </div>
        ) : (
          <div className="h-16 w-16 sm:h-24 sm:w-24 rounded-full bg-zinc-900/80 border border-zinc-800" />
        )}
      </div>

      {/* Bottom Product-Style Footer: Title, Subtitle, and Orange Selection Circle */}
      <div className="relative z-10 mt-1 sm:mt-2 flex items-end justify-between gap-2 sm:gap-3 pt-1 sm:pt-2">
        <div className="min-w-0 flex-1">
          <h3
            className={clsx(
              'font-bold tracking-tight leading-snug transition-colors',
              isKiosk ? 'text-base sm:text-lg' : 'text-xs sm:text-base',
              isSelected ? 'text-white' : 'text-zinc-100 group-hover:text-white'
            )}
          >
            {title}
          </h3>

          {subtitle && (
            <p className="mt-0.5 sm:mt-1 line-clamp-2 text-[10px] sm:text-xs leading-relaxed text-[#8E8E98]">
              {subtitle}
            </p>
          )}
        </div>

        {/* Signature Circular Action Indicator (Matches Reference Screenshot 1:1) */}
        <div
          className={clsx(
            'flex h-6 w-6 sm:h-7 sm:w-7 shrink-0 items-center justify-center rounded-full transition-transform duration-200',
            isSelected
              ? 'bg-[#FF5500] text-zinc-950 scale-105 shadow-[0_0_14px_rgba(255,85,0,0.5)]'
              : 'bg-[#25252B] text-zinc-400 group-hover:bg-[#32323A] group-hover:text-zinc-100 group-hover:scale-105'
          )}
          aria-hidden="true"
        >
          {isSelected ? (
            <Check className="h-3.5 w-3.5 sm:h-4 sm:w-4 stroke-[2.75]" />
          ) : (
            <Plus className="h-3 w-3 sm:h-3.5 sm:w-3.5 stroke-[2.25] transition-transform duration-200 group-hover:rotate-90" />
          )}
        </div>
      </div>
    </button>
  );
}
