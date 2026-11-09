import { createServerClient } from '@supabase/ssr';
import { type NextRequest, NextResponse } from 'next/server';

export async function updateSession(request: NextRequest, initialResponse?: NextResponse) {
  const response = initialResponse ?? NextResponse.next({
    request: {
      headers: request.headers,
    },
  });

  const pathname = request.nextUrl.pathname;
  const adminMatch = pathname.match(/^\/(ar|fr|en)\/admin(?:\/(.*))?$/);
  const isLoginRoute = adminMatch && adminMatch[2] === 'login';
  const isProtectedAdminRoute = Boolean(adminMatch && !isLoginRoute);
  const hasDemoCookie = request.cookies.get('pf_admin_demo')?.value === 'authenticated';

  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY;

  if (!supabaseUrl || !supabaseKey) {
    if (isProtectedAdminRoute && !hasDemoCookie) {
      const locale = adminMatch?.[1] || 'ar';
      const loginUrl = new URL(`/${locale}/admin/login`, request.url);
      return NextResponse.redirect(loginUrl);
    }
    return response;
  }

  const supabase = createServerClient(
    supabaseUrl,
    supabaseKey,
    {
      cookies: {
        getAll() {
          return request.cookies.getAll();
        },
        setAll(cookiesToSet: Array<{ name: string; value: string; options?: any }>) {
          cookiesToSet.forEach(({ name, value }) => request.cookies.set(name, value));
          cookiesToSet.forEach(({ name, value, options }) =>
            response.cookies.set(name, value, options)
          );
        },
      },
    }
  );

  // Refresh auth session and verify user identity
  const {
    data: { user },
  } = await supabase.auth.getUser();

  if (isProtectedAdminRoute && !user && !hasDemoCookie) {
    const locale = adminMatch?.[1] || 'ar';
    const loginUrl = new URL(`/${locale}/admin/login`, request.url);
    return NextResponse.redirect(loginUrl);
  }

  return response;
}
