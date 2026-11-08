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

  // GPU-only 3D transforms for card, floating object, and counter-moving floor shadow
  const cardTransform = tilt.active
    ? `perspective(900px) rotateX(${(-tilt.y * 5.5).toFixed(2)}deg) rotateY(${(tilt.x * 5.5).toFixed(2)}deg) translateZ(0)`
    : 'perspective(900px) rotateX(0deg) rotateY(0deg) translateZ(0)';

  const objectTransform = tilt.active
    ? `translate3d(${(tilt.x * 14).toFixed(1)}px, ${(tilt.y * 10 - 8).toFixed(1)}px, 24px) scale(1.07)`
    : isSelected
    ? 'translate3d(0px, -6px, 16px) scale(1.04)'
    : 'translate3d(0px, 0px, 0px) scale(1)';

  const shadowTransform = tilt.active
    ? `translate3d(${(-tilt.x * 10).toFixed(1)}px, ${(-tilt.y * 4 + 4).toFixed(1)}px, 0px) scale(0.88)`
    : 'translate3d(0px, 0px, 0px) scale(1)';

  const spotlightTransform = tilt.active
    ? `translate3d(${(tilt.x * 28).toFixed(1)}px, ${(tilt.y * 22).toFixed(1)}px, 0px)`
    : 'translate3d(0px, 0px, 0px)';

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
        isKiosk ? 'min-h-[300px] p-6' : 'min-h-[275px] p-5',
        isSelected
          ? 'border-[#FF5500] bg-[#16161A] ring-1 ring-[#FF5500]/50'
          : 'border-[#242429] bg-[#141417] hover:border-[#3A3A42] hover:bg-[#17171B]'
      )}
    >
      {/* Subtle Studio Horizon Pedestal Plane (blends object into card like reference screenshot) */}
      <div
        className="pointer-events-none absolute inset-x-0 top-0 h-[64%] overflow-hidden"
        aria-hidden="true"
      >
        {/* Studio Backwall to Pedestal Gradient */}
        <div className="absolute inset-0 bg-gradient-to-b from-[#19191E]/60 via-[#121215]/80 to-[#141417]" />

        {/* Dynamic Interactive Studio Rim Lighting Spotlight */}
        <div
          style={{ transform: spotlightTransform }}
          className={clsx(
            'absolute inset-0 transition-opacity duration-300 bg-[radial-gradient(circle_at_50%_48%,rgba(255,85,0,0.16),rgba(255,255,255,0.03)_45%,transparent_72%)]',
            tilt.active || isSelected ? 'opacity-100' : 'opacity-45 group-hover:opacity-85'
          )}
        />

        {/* Subtle Studio Pedestal Floor Line */}
        <div className="absolute inset-x-4 bottom-5 h-px bg-gradient-to-r from-transparent via-zinc-800/70 to-transparent" />
      </div>

      {/* Top Index Micro-Pill */}
      <div className="relative z-10 flex w-full items-center justify-between">
        <span
          className={clsx(
            'font-mono text-[10px] font-semibold tracking-widest uppercase transition-colors',
            isSelected ? 'text-[#FF5500]' : 'text-zinc-600 group-hover:text-zinc-400'
          )}
        >
          0{index + 1}
        </span>
      </div>

      {/* Center Stage: Isolated Transparent PNG Object with Seamless Drop Shadow & 3D Parallax */}
      <div className="relative z-10 my-auto flex h-36 sm:h-40 w-full items-center justify-center">
        {/* Counter-shifting Seamless Studio Floor Shadow */}
        <div
          style={{ transform: shadowTransform }}
          className={clsx(
            'pointer-events-none absolute bottom-1.5 h-5 w-28 rounded-full bg-black/85 blur-md transition-transform duration-200 ease-out',
            isSelected && 'shadow-[0_0_20px_rgba(255,85,0,0.35)]'
          )}
          aria-hidden="true"
        />

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
                'h-32 w-32 sm:h-36 sm:w-36 object-contain select-none pointer-events-none transition-opacity duration-200',
                ' brightness-[0.98] contrast-[1.06] drop-shadow-[0_14px_16px_rgba(0,0,0,0.85)]',
                (tilt.active || isSelected) && 'brightness-[1.05]'
              )}
            />
          </div>
        ) : (
          <div className="h-24 w-24 rounded-full bg-zinc-900/80 border border-zinc-800" />
        )}
      </div>

      {/* Bottom Product-Style Footer: Title, Subtitle, and Orange Selection Circle */}
      <div className="relative z-10 mt-2 flex items-end justify-between gap-3 pt-2">
        <div className="min-w-0 flex-1">
          <h3
            className={clsx(
              'font-bold tracking-tight leading-snug transition-colors',
              isKiosk ? 'text-base sm:text-lg' : 'text-sm sm:text-base',
              isSelected ? 'text-white' : 'text-zinc-100 group-hover:text-white'
            )}
          >
            {title}
          </h3>

          {subtitle && (
            <p className="mt-1 line-clamp-2 text-[11px] sm:text-xs leading-relaxed text-[#8E8E98]">
              {subtitle}
            </p>
          )}
        </div>

        {/* Signature Circular Action Indicator (Matches Reference Screenshot 1:1) */}
        <div
          className={clsx(
            'flex h-7 w-7 shrink-0 items-center justify-center rounded-full transition-transform duration-200',
            isSelected
              ? 'bg-[#FF5500] text-zinc-950 scale-105 shadow-[0_0_14px_rgba(255,85,0,0.5)]'
              : 'bg-[#25252B] text-zinc-400 group-hover:bg-[#32323A] group-hover:text-zinc-100 group-hover:scale-105'
          )}
          aria-hidden="true"
        >
          {isSelected ? (
            <Check className="h-4 w-4 stroke-[2.75]" />
          ) : (
            <Plus className="h-3.5 w-3.5 stroke-[2.25] transition-transform duration-200 group-hover:rotate-90" />
          )}
        </div>
      </div>
    </button>
  );
}
